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
}

/// 好友请求 + 申请人资料联表结果
class FriendRequestWithProfile {
  final FriendRequest request;
  final UserProfile? fromProfile;

  FriendRequestWithProfile({required this.request, required this.fromProfile});
}
