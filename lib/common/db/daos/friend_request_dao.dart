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

  /// 收到的好友申请（friendId == 当前用户，待确认状态）。
  Stream<List<FriendRequest>> watchIncoming(String currentUid) =>
      (select(friendRequests)
            ..where(
                (r) => r.friendId.equals(currentUid) & r.status.equals(0)))
          .watch();

  /// 发出的好友申请（uid == 当前用户）。
  Stream<List<FriendRequest>> watchOutgoing(String currentUid) =>
      (select(friendRequests)
            ..where((r) => r.uid.equals(currentUid)))
          .watch();

  /// 待处理申请数量（红点/角标用）。
  Stream<int> watchPendingCount(String currentUid) {
    final q = selectOnly(friendRequests)
      ..addColumns([friendRequests.id.count()])
      ..where(friendRequests.friendId.equals(currentUid) &
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
          userProfiles, userProfiles.userId.equalsExp(friendRequests.uid)),
    ])
      ..where(friendRequests.friendId.equals(currentUid) &
          friendRequests.status.equals(0));
    return query.map((row) {
      return FriendRequestWithProfile(
        request: row.readTable(friendRequests),
        fromProfile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 发出的好友申请 + 对方资料联表查询（含头像、昵称）。
  Stream<List<FriendRequestWithProfile>> watchOutgoingWithProfile(
      String currentUid) {
    final query = select(friendRequests).join([
      leftOuterJoin(
          userProfiles, userProfiles.userId.equalsExp(friendRequests.friendId)),
    ])
      ..where(friendRequests.uid.equals(currentUid) &
          friendRequests.status.equals(0));
    return query.map((row) {
      return FriendRequestWithProfile(
        request: row.readTable(friendRequests),
        fromProfile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 收到的好友申请（全部状态）+ 申请人资料联表查询。
  Stream<List<FriendRequestWithProfile>> watchAllIncomingWithProfile(
      String currentUid) {
    final query = select(friendRequests).join([
      leftOuterJoin(
          userProfiles, userProfiles.userId.equalsExp(friendRequests.uid)),
    ])
      ..where(friendRequests.friendId.equals(currentUid));
    return query.map((row) {
      return FriendRequestWithProfile(
        request: row.readTable(friendRequests),
        fromProfile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 发出的好友申请（全部状态）+ 对方资料联表查询。
  Stream<List<FriendRequestWithProfile>> watchAllOutgoingWithProfile(
      String currentUid) {
    final query = select(friendRequests).join([
      leftOuterJoin(
          userProfiles, userProfiles.userId.equalsExp(friendRequests.friendId)),
    ])
      ..where(friendRequests.uid.equals(currentUid));
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
      updateTime: Value(now),
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

  /// 从服务端同步好友申请列表（增量模式），同时处理收到和发出的申请。
  ///
  /// 服务端返回的列表中，[uid] 是发起申请的人，[friend_id] 是被添加的目标：
  /// - [uid] == currentUid → 发出的申请
  /// - [friend_id] == currentUid → 收到的申请
  ///
  /// [sinceId] == 0 时（首次拉取），先删除当前用户相关的所有待处理申请，
  /// 再批量插入服务端返回的全量列表。
  ///
  /// [sinceId] > 0 时（增量拉取），直接 upsert 服务端返回的新记录，
  /// 保留本地已有数据。
  ///
  /// 同时将申请人的资料（name, avatar_url 等）写入 [UserProfiles] 表。
  Future<void> syncFromServer(
    String currentUid,
    List<Map<String, dynamic>> list, {
    int sinceId = 0,
  }) async {
    await batch((batch) {
      // 首次拉取时清空当前用户相关的所有待处理申请
      if (sinceId == 0) {
        batch.deleteWhere(
          friendRequests,
          (r) => (r.friendId.equals(currentUid) | r.uid.equals(currentUid)) &
              r.status.equals(0),
        );
      }

      final now = DateTime.now().millisecondsSinceEpoch;

      for (final item in list) {
        final serverId = item['id'] as int?;
        final uid = item['uid'] as String? ?? '';
        final friendId = item['friend_id'] as String? ?? '';

        // 只保留与当前用户相关的申请（收到的或发出的）
        final isReceived = friendId == currentUid;
        final isSent = uid == currentUid;
        if (!isReceived && !isSent) continue;

        final message = item['msg'] as String?;
        final status = item['status'] as int? ?? 0;
        final createTime = _parseTime(item['created_time'] as String?) ?? now;

        // 始终使用服务端返回的 id，保证 getMaxId() 与服务端游标一致
        final companion = serverId != null
            ? FriendRequestsCompanion(
                id: Value(serverId),
                uid: Value(uid),
                friendId: Value(friendId),
                message: Value(message),
                status: Value(status),
                createTime: Value(createTime),
                updateTime: Value(now),
              )
            : FriendRequestsCompanion.insert(
                uid: uid,
                friendId: friendId,
                message: Value(message),
                status: Value(status),
                createTime: createTime,
                updateTime: now,
              );

        batch.insert(
          friendRequests,
          companion,
          mode: InsertMode.insertOrReplace,
        );

        // 将申请人的资料写入 user_profiles（服务端返回的是平铺字段）
        if (uid.isNotEmpty) {
          batch.insert(
            userProfiles,
            UserProfilesCompanion.insert(
              userId: uid,
              name: Value(item['name'] as String?),
              alias: Value(item['alias'] as String? ?? item['alias'] as String?),
              avatarUrl: Value(item['avatar_url'] as String?),
              email: Value(item['email'] as String?),
              region: Value(item['region'] as String?),
              gender: Value(item['gender'] as int? ?? 0),
              isSelf: const Value(false),
              createTime: now,
              updateTime: now,
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }

  /// 解析服务端返回的时间字符串（"2026-06-21 19:21:31"）为毫秒时间戳。
  int? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    return DateTime.tryParse(timeStr)?.millisecondsSinceEpoch;
  }
}

/// 好友请求 + 申请人资料联表结果
class FriendRequestWithProfile {
  final FriendRequest request;
  final UserProfile? fromProfile;

  FriendRequestWithProfile({required this.request, required this.fromProfile});
}
