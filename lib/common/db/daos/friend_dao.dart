import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'friend_dao.g.dart';

/// 好友 DAO。
///
/// 管理已确认的好友关系，支持分组、备注和联表查询好友资料。
@DriftAccessor(tables: [Friends, UserProfiles])
class FriendDao extends DatabaseAccessor<AppDatabase> with _$FriendDaoMixin {
  FriendDao(super.db);

  /// 插入或更新好友。
  Future<void> upsert(FriendsCompanion data) =>
      into(friends).insertOnConflictUpdate(data);

  /// 批量同步好友列表（全量替换，用于初次拉取服务端好友列表）。
  Future<void> syncFromServer(List<FriendsCompanion> list) async {
    await batch((batch) {
      batch.deleteAll(friends);
      batch.insertAll(friends, list, mode: InsertMode.insertOrReplace);
    });
  }

  /// 按分组获取好友列表。
  Stream<List<Friend>> watchByGroup(String groupName) =>
      (select(friends)..where((f) => f.groupName.equals(groupName))).watch();

  /// 获取所有正常好友（status == 1）。
  Stream<List<Friend>> watchAll() =>
      (select(friends)..where((f) => f.status.equals(1))).watch();

  /// 拉黑列表（status == 2）。
  Stream<List<Friend>> watchBlocked() =>
      (select(friends)..where((f) => f.status.equals(2))).watch();

  /// 按 userId 查找好友。
  Future<Friend?> getByUserId(String userId) =>
      (select(friends)..where((f) => f.userId.equals(userId)))
          .getSingleOrNull();

  /// 好友详情（联表 user_profiles，含头像、昵称等展示信息）。
  Stream<List<FriendWithProfile>> watchAllWithProfile() {
    final query = select(friends).join([
      leftOuterJoin(userProfiles, userProfiles.userId.equalsExp(friends.userId)),
    ]);
    return query.map((row) {
      return FriendWithProfile(
        friend: row.readTable(friends),
        profile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 更新备注名。
  Future<void> updateRemark(String userId, String remark) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(remark: Value(remark), updatedAt: Value(now)));
  }

  /// 更新好友状态（拉黑/取消拉黑）。
  Future<void> updateStatus(String userId, int status) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(status: Value(status), updatedAt: Value(now)));
  }

  /// 删除好友。
  Future<void> deleteByUserId(String userId) =>
      (delete(friends)..where((f) => f.userId.equals(userId))).go();
}

/// 好友 + 资料联表结果
class FriendWithProfile {
  final Friend friend;
  final UserProfile? profile;

  FriendWithProfile({required this.friend, required this.profile});
}
