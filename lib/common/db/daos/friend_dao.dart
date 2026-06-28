import 'package:drift/drift.dart';
import '../database.dart';
import '../../utils/time_utils.dart';
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

  /// 获取本地好友表中最大的 updateTime，转为服务端时间字符串。
  ///
  /// 用于增量拉取：将最大 updateTime 字符串传给服务端，只拉取在此之后更新的记录。
  /// 表为空时返回空字符串。
  Future<String> getMaxUpdateTime() async {
    final query = selectOnly(friends)
      ..addColumns([friends.updateTime.max()]);
    final row = await query.getSingleOrNull();
    final maxMs = row?.read(friends.updateTime.max()) ?? 0;
    return TimeUtils.toServerTimeString(maxMs);
  }

  /// 从服务端同步好友列表（支持增量拉取）。
  ///
  /// [sinceUpdateTime] 本地已存储的最大 updateTime 字符串。
  /// - 为空时全量同步：清空本地好友表再插入服务端返回的数据。
  /// - 非空时增量同步：仅 upsert 服务端返回的新记录，保留本地已有数据。
  ///
  /// 同时将好友的资料（name、avatar_url、email 等）写入 [UserProfiles] 表。
  Future<void> syncFromServer(
    List<Map<String, dynamic>> list, {
    String sinceUpdateTime = '',
  }) async {
    await batch((batch) {
      // 首次拉取时清空好友表
      if (sinceUpdateTime.isEmpty) {
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
        final createTime = TimeUtils.parseServerTime(item['create_time'] as String?) ?? now;
        final updateTime = TimeUtils.parseServerTime(item['update_time'] as String?) ?? now;

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
            updateTime: updateTime,
          ),
          mode: InsertMode.insertOrReplace,
        );

        // 仅当服务端返回了 name 时才写入 user_profiles，
        // 避免用 null 覆盖本地已缓存的用户资料。
        final profileName = item['name'] as String?;
        if (profileName != null && profileName.isNotEmpty) {
          batch.insert(
            userProfiles,
            UserProfilesCompanion.insert(
              userId: userId,
              name: Value(profileName),
              alias: Value(item['alias'] as String?),
              avatarUrl: Value(item['avatar_url'] as String?),
              email: Value(item['email'] as String?),
              region: Value(item['region'] as String?),
              gender: Value(item['gender'] as int? ?? 0),
              isSelf: const Value(false),
              createTime: createTime,
              updateTime: updateTime,
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
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

  /// 更新好友状态（拉黑/取消拉黑/删除好友）。
  Future<void> updateStatus(String userId, int status) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(status: Value(status), updateTime: Value(now)));
  }

  /// 更新星标好友。
  Future<void> updateIsStarred(String userId, int isStarred) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(isStarred: Value(isStarred), updateTime: Value(now)));
  }

  /// 更新隐藏好友。
  Future<void> updateIsHidden(String userId, int isHidden) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friends)..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(isHidden: Value(isHidden), updateTime: Value(now)));
  }

  /// 删除好友。
  Future<void> deleteByUserId(String userId) =>
      (delete(friends)..where((f) => f.userId.equals(userId))).go();

  /// 清空所有好友（调试用）。
  Future<void> clear() => delete(friends).go();

  /// 获取所有好友中 user_profiles.name 为 null 的 userId 列表。
  ///
  /// 用于在同步好友列表后，补充拉取缺失的用户资料。
  Future<List<String>> getFriendIdsMissingProfile() async {
    final query = selectOnly(friends)
      ..addColumns([friends.userId])
      ..join([
        leftOuterJoin(
            userProfiles, userProfiles.userId.equalsExp(friends.userId)),
      ])
      ..where(userProfiles.name.isNull());
    final rows = await query.get();
    return rows
        .map((row) => row.read(friends.userId))
        .whereType<String>()
        .toList();
  }

  /// 插入或更新单条用户资料（仅设置非 null 字段，不覆盖已有数据）。
  ///
  /// 与 [syncFromServer] 不同，该方法用于从 [getUserFullInfoRsp]
  /// 等单用户查询结果中补充资料。
  Future<void> upsertUserProfile(Map<String, dynamic> data) async {
    final userId = data['uid']?.toString() ?? '';
    if (userId.isEmpty) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final name = data['name'] as String?;
    final alias = data['alias'] as String?;
    final avatarUrl = data['avatar_url'] as String?;
    final email = data['email'] as String?;
    final region = data['region'] as String?;
    final gender = data['gender'] as int?;
    final ex = data['ex'] as String?;

    // 仅设置非 null 字段：Value.absent() 在 ON CONFLICT UPDATE 时不会覆盖已有值
    final companion = UserProfilesCompanion(
      userId: Value(userId),
      name: name != null ? Value(name) : Value.absent(),
      alias: alias != null ? Value(alias) : Value.absent(),
      avatarUrl: avatarUrl != null ? Value(avatarUrl) : Value.absent(),
      email: email != null ? Value(email) : Value.absent(),
      region: region != null ? Value(region) : Value.absent(),
      gender: gender != null ? Value(gender) : Value.absent(),
      ex: ex != null ? Value(ex) : Value.absent(),
      isSelf: const Value(false),
      createTime: Value(now),
      updateTime: Value(now),
    );

    await into(userProfiles).insertOnConflictUpdate(companion);
  }
}

/// 好友 + 资料联表结果
class FriendWithProfile {
  final Friend friend;
  final UserProfile? profile;

  FriendWithProfile({required this.friend, required this.profile});
}
