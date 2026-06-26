import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'user_dao.g.dart';

/// 用户资料 DAO。
///
/// 管理当前用户及联系人的基本信息缓存。
@DriftAccessor(tables: [UserProfiles])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  /// 插入或更新用户资料。
  Future<void> upsert(UserProfilesCompanion data) =>
      into(userProfiles).insertOnConflictUpdate(data);

  /// 批量写入用户资料。
  Future<void> upsertAll(List<UserProfilesCompanion> list) =>
      batch((batch) => batch.insertAll(
            userProfiles,
            list,
            mode: InsertMode.insertOrReplace,
          ));

  /// 按 userId 查找。
  Future<UserProfile?> getByUserId(String userId) =>
      (select(userProfiles)..where((u) => u.userId.equals(userId)))
          .getSingleOrNull();

  /// 获取当前登录用户。
  Future<UserProfile?> getSelf() =>
      (select(userProfiles)..where((u) => u.isSelf.equals(true)))
          .getSingleOrNull();

  /// 监听所有用户资料。
  Stream<List<UserProfile>> watchAll() => select(userProfiles).watch();

  /// 按 userId 删除。
  Future<void> deleteByUserId(String userId) =>
      (delete(userProfiles)..where((u) => u.userId.equals(userId))).go();

  /// 清空所有用户资料（调试用）。
  Future<void> clear() => delete(userProfiles).go();
}
