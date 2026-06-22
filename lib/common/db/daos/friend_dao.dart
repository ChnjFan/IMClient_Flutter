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

  /// 获取本地好友表中最大的 id。
  ///
  /// 好友表以 userId 为主键，使用服务端返回的 id 作为增量拉取的游标。
  /// 表为空时返回 0。
  Future<int> getMaxId() async {
    final query = selectOnly(friends)
      ..addColumns([friends.id.max()]);
    final row = await query.getSingleOrNull();
    final maxId = row?.read(friends.id.max()) ?? 0;
    return maxId;
  }

  /// 从服务端同步好友列表（支持增量拉取）。
  ///
  /// [sinceId] 本地已存储的最大 id。
  /// - 传 0 时全量同步：清空本地好友表再插入服务端返回的数据。
  /// - 传 >0 时增量同步：仅 upsert 服务端返回的新记录，保留本地已有数据。
  ///
  /// 同时将好友的资料（name、avatar_url、email 等）写入 [UserProfiles] 表。
  Future<void> syncFromServer(
    List<Map<String, dynamic>> list, {
    int sinceId = 0,
  }) async {
    await batch((batch) {
      // 首次拉取时清空好友表
      if (sinceId == 0) {
        batch.deleteAll(friends);
      }

      final now = DateTime.now().millisecondsSinceEpoch;

      for (final item in list) {
        final userId = item['friend_id'] as String? ?? '';
        if (userId.isEmpty) continue;

        final alias = item['alias'] as String?;
        final groupName = item['group_name'] as String? ?? '我的好友';
        final status = item['status'] as int? ?? 1;
        final source = item['source'] as String?;
        final id = _parseInt(item['id']);
        final createTime = _parseTime(item['created_time'] as String?) ?? now;

        batch.insert(
          friends,
          FriendsCompanion.insert(
            userId: userId,
            alias: Value(alias),
            groupName: Value(groupName),
            status: Value(status),
            source: Value(source),
            id: Value(id),
            createTime: createTime,
            updateTime: now,
          ),
          mode: InsertMode.insertOrReplace,
        );

        // 将好友的资料写入 user_profiles
        batch.insert(
          userProfiles,
          UserProfilesCompanion.insert(
            userId: userId,
            name: Value(item['name'] as String?),
            alias: Value(item['alias'] as String?),
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
    });
  }

  /// 解析服务端返回的 id 字段（兼容 int 和 String 类型）。
  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// 解析服务端返回的时间字符串（"2026-06-21 19:21:31"）为毫秒时间戳。
  int? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    return DateTime.tryParse(timeStr)?.millisecondsSinceEpoch;
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

  /// 更新别名（备注）。
  Future<void> updateAlias(String userId, String alias) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(alias: Value(alias), updateTime: Value(now)));
  }

  /// 更新好友状态（拉黑/取消拉黑）。
  Future<void> updateStatus(String userId, int status) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(status: Value(status), updateTime: Value(now)));
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
