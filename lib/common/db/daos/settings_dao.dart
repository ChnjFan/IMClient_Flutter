import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'settings_dao.g.dart';

/// 应用设置 DAO。
///
/// Key-value 形式的零散配置项读写，保留 SharedPreferences 的灵活性。
@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// 写入配置项。
  Future<void> put(String key, String value) =>
      into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion(key: Value(key), value: Value(value)),
      );

  /// 读取配置项。
  Future<String?> get(String key) async {
    final row = await (select(appSettings)
          ..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  /// 读取配置项（带默认值）。
  Future<String> getString(String key, {String defaultValue = ''}) async {
    final v = await get(key);
    return v ?? defaultValue;
  }

  /// 读取 int 配置项。
  Future<int?> getInt(String key) async {
    final v = await get(key);
    return v != null ? int.tryParse(v) : null;
  }

  /// 写入 int 配置项。
  Future<void> putInt(String key, int value) => put(key, value.toString());

  /// 读取 bool 配置项。
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final v = await get(key);
    return v != null ? v == 'true' : defaultValue;
  }

  /// 写入 bool 配置项。
  Future<void> putBool(String key, bool value) =>
      put(key, value.toString());

  /// 监听单个配置项变化。
  Stream<String?> watch(String key) =>
      (select(appSettings)..where((s) => s.key.equals(key)))
          .watchSingleOrNull()
          .map((row) => row?.value);

  /// 删除配置项。
  Future<void> remove(String key) =>
      (delete(appSettings)..where((s) => s.key.equals(key))).go();
}
