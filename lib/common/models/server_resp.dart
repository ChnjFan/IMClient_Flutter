import 'dart:convert';

/// 通用服务端 API 应答模型。
///
/// error 与业务字段在同一层：
/// ```json
/// {
///   "error": 0,
///   "userID": "123456",
///   "imToken": "eyJ..."
/// }
/// ```
class ServerResp {
  /// 错误码，0 表示成功
  int errCode;
  /// 完整的响应数据（包含 error 字段在内的整个 map）
  late Map<String, dynamic> _raw;

  ServerResp({
    this.errCode = -1,
  });

  factory ServerResp.fromJson(Map<String, dynamic> map) {
    final resp = ServerResp(
      errCode: map['error'] ?? -1,
    );
    resp._raw = map;
    return resp;
  }

  /// 是否成功
  bool get isSuccess => errCode == 0;

  /// 获取指定字段的业务数据
  T? get<T>(String key) => _raw[key] as T?;

  /// 获取整个业务数据 map（不含 error 字段）
  Map<String, dynamic> get data => Map<String, dynamic>.from(_raw)..remove('error');

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(_raw);

  @override
  String toString() => jsonEncode(_raw);
}

// ============================================================
// 错误码定义
// ============================================================

/// 服务端错误码及其中文描述。
class ServerError {
  ServerError._();

  /// 根据错误码获取中文错误信息
  static String getMsg(int errorCode) {
    return _errorZH['$errorCode'] ?? _errorZH['default'] ?? '未知错误';
  }

  // ---- 通用错误 ----
  static const int success = 0;
  static const int errJson = 1001;
  static const int errRpc = 1002;
  static const int errMysql = 1003;
  static const int errRedis = 1004;
  static const int errFile = 1005;
  static const int errRequest = 1006;
  // ---- 验证码 ----
  static const int errCodeExpired = 2001;
  static const int errCodeNotFound = 2002;
  // ---- 用户相关 ----
  static const int errUserExists = 3001;
  static const int errUserEmailNotExists = 3002;
  // ---- 登录 ----
  static const int errLoginTokenInvalid = 4001;
  static const int errLoginUidInvalid = 4002;

  static const Map<String, String> _errorZH = {
    // 通用
    '0': '成功',
    '1001': '请求参数错误',
    '1002': '服务器内部通信错误',
    '1003': '数据库错误',
    '1004': 'Redis错误',
    '1005': '文件错误',
    '1006': '请求错误',
    // 验证码
    '2001': '验证码已过期',
    '2002': '验证码不存在',
    // 账号
    '3001': '账号已注册',
    '3002': '邮箱未注册',
    // 登录
    '4001': 'Token 无效',
    '4002': 'UID 无效',
  };
}
