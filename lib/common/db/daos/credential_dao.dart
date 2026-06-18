import 'dart:convert';
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'credential_dao.g.dart';

/// 登录凭证 DAO。
///
/// 提供当前登录凭证的读写删操作，凭证表仅维护一条记录。
@DriftAccessor(tables: [UserCredentials])
class CredentialDao extends DatabaseAccessor<AppDatabase>
    with _$CredentialDaoMixin {
  CredentialDao(super.db);

  // ---- 写入 ----

  /// 保存登录凭证（先清空旧数据，再插入新记录）。
  Future<void> save({
    required String userId,
    required String token,
    String areaCode = '+86',
    String? phoneNumber,
    int loginType = 0,
    Map<String, dynamic>? loginAccount,
    String? serverHost,
    String? serverPort,
    Map<String, dynamic>? serverConfig,
  }) async {
    await delete(userCredentials).go();

    final now = DateTime.now().millisecondsSinceEpoch;
    await into(userCredentials).insert(
      UserCredentialsCompanion(
        userId: Value(userId),
        token: Value(token),
        areaCode: Value(areaCode),
        phoneNumber: Value.absentIfNull(phoneNumber),
        loginType: Value(loginType),
        loginAccount: Value.absentIfNull(
          loginAccount != null ? jsonEncode(loginAccount) : null,
        ),
        serverHost: Value.absentIfNull(serverHost),
        serverPort: Value.absentIfNull(serverPort),
        serverConfig: Value.absentIfNull(
          serverConfig != null ? jsonEncode(serverConfig) : null,
        ),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  // ---- 读取 ----

  /// 获取当前登录凭证（最多一条记录）。
  Future<UserCredential?> getLatest() =>
      (select(userCredentials)..limit(1)).getSingleOrNull();

  /// 监听登录凭证变化。
  Stream<UserCredential?> watchLatest() =>
      (select(userCredentials)..limit(1)).watchSingleOrNull();

  // ---- 删除 ----

  /// 清除所有登录凭证。
  Future<void> clear() => delete(userCredentials).go();
}
