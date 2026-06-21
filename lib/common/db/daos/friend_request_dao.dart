import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'friend_request_dao.g.dart';

/// 好友请求 DAO。
///
/// 管理收到和发出的好友申请，处理完成后移入 [Friends] 表。
@DriftAccessor(tables: [FriendRequests, UserProfiles])
class FriendRequestDao extends DatabaseAccessor<AppDatabase>
    with _$FriendRequestDaoMixin {
  FriendRequestDao(super.db);

  /// 插入新的好友请求，返回自增 id。
  Future<int> insert(FriendRequestsCompanion data) =>
      into(friendRequests).insert(data);

  /// 收到的好友申请（toUid == 当前用户，待确认状态）。
  Stream<List<FriendRequest>> watchIncoming(String currentUid) =>
      (select(friendRequests)
            ..where(
                (r) => r.toUid.equals(currentUid) & r.status.equals(0)))
          .watch();

  /// 发出的好友申请（fromUid == 当前用户）。
  Stream<List<FriendRequest>> watchOutgoing(String currentUid) =>
      (select(friendRequests)
            ..where((r) => r.fromUid.equals(currentUid)))
          .watch();

  /// 待处理申请数量（红点/角标用）。
  Stream<int> watchPendingCount(String currentUid) {
    final q = selectOnly(friendRequests)
      ..addColumns([friendRequests.id.count()])
      ..where(friendRequests.toUid.equals(currentUid) &
          friendRequests.status.equals(0));
    return q
        .map((row) => row.read(friendRequests.id.count()) ?? 0)
        .watchSingle();
  }

  /// 收到的好友申请 + 申请人资料联表查询（含头像、昵称）。
  Stream<List<FriendRequestWithProfile>> watchIncomingWithProfile(
      String currentUid) {
    final query = select(friendRequests).join([
      leftOuterJoin(
          userProfiles, userProfiles.userId.equalsExp(friendRequests.fromUid)),
    ])
      ..where(friendRequests.toUid.equals(currentUid) &
          friendRequests.status.equals(0));
    return query.map((row) {
      return FriendRequestWithProfile(
        request: row.readTable(friendRequests),
        fromProfile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 处理好友请求（同意/拒绝）。
  Future<void> handle(int id, bool accept) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friendRequests)..where((r) => r.id.equals(id)))
        .write(FriendRequestsCompanion(
      status: Value(accept ? 1 : 2),
      handledAt: Value(now),
      updatedAt: Value(now),
    ));
  }

  /// 删除请求记录。
  Future<void> deleteById(int id) =>
      (delete(friendRequests)..where((r) => r.id.equals(id))).go();

  /// 获取本地好友请求表中最大的 id。
  ///
  /// 用于增量拉取：将最大 id 传给服务端，只拉取 id > sinceId 的新申请。
  /// 表为空时返回 0。
  Future<int> getMaxId() async {
    final query = selectOnly(friendRequests)
      ..addColumns([friendRequests.id.max()]);
    final row = await query.getSingleOrNull();
    final maxId = row?.read(friendRequests.id.max()) ?? 0;
    return maxId;
  }

  /// 从服务端同步好友申请列表（增量模式）。
  ///
  /// [sinceId] == 0 时（首次拉取），先删除当前用户待处理的所有收到申请，
  /// 再批量插入服务端返回的全量列表。
  ///
  /// [sinceId] > 0 时（增量拉取），直接 upsert 服务端返回的新记录，
  /// 保留本地已有数据。
  ///
  /// 同时将申请人的资料（name, avatar_url 等）写入 [UserProfiles] 表。
  Future<void> syncIncomingFromServer(
    String currentUid,
    List<Map<String, dynamic>> list, {
    int sinceId = 0,
  }) async {
    await batch((batch) {
      // 首次拉取时清空旧待处理申请
      if (sinceId == 0) {
        batch.deleteWhere(
          friendRequests,
          (r) => r.toUid.equals(currentUid) & r.status.equals(0),
        );
      }

      final now = DateTime.now().millisecondsSinceEpoch;

      for (final item in list) {
        final serverId = item['id'] as int?;
        final fromUid = item['uid'] as String? ?? '';
        final toUid = item['friend_uid'] as String? ?? '';
        final message = item['msg'] as String?;
        final status = item['status'] as int? ?? 0;
        final createdAt = item['created_time'] as int? ?? now;

        // 始终使用服务端返回的 id，保证 getMaxId() 与服务端游标一致
        final companion = serverId != null
            ? FriendRequestsCompanion(
                id: Value(serverId),
                fromUid: Value(fromUid),
                toUid: Value(toUid),
                message: Value(message),
                status: Value(status),
                createdAt: Value(createdAt),
                updatedAt: Value(now),
              )
            : FriendRequestsCompanion.insert(
                fromUid: fromUid,
                toUid: toUid,
                message: Value(message),
                status: Value(status),
                createdAt: createdAt,
                updatedAt: now,
              );

        batch.insert(
          friendRequests,
          companion,
          mode: InsertMode.insertOrReplace,
        );

        // 如果带有申请人资料，写入 user_profiles
        final profile = item['from_profile'];
        if (profile is Map<String, dynamic>) {
          final profileUid = profile['uid'] as String? ?? fromUid;
          batch.insert(
            userProfiles,
            UserProfilesCompanion.insert(
              userId: profileUid,
              name: Value(profile['name'] as String?),
              avatarUrl: Value(profile['avatar_url'] as String?),
              email: Value(profile['email'] as String?),
              isSelf: const Value(false),
              createdAt: now,
              updatedAt: now,
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }
}

/// 好友请求 + 申请人资料联表结果
class FriendRequestWithProfile {
  final FriendRequest request;
  final UserProfile? fromProfile;

  FriendRequestWithProfile({required this.request, required this.fromProfile});
}
