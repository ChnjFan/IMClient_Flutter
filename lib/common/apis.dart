import 'models/login_certificate.dart';
import 'models/urls.dart';
import 'utils/http_utils.dart';
import 'utils/logger.dart';

/// API 服务层，封装所有后端接口调用。
class ApiService {
  ApiService._();

  // ============================================================
  // 用户认证
  // ============================================================

  /// 邮箱 + 密码登录。
  ///
  /// 成功返回 [LoginCertificate]，失败抛出 [(errCode, errMsg)] 或网络异常。
  static Future<LoginCertificate> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await HttpUtils.post(Urls.userLogin, data: {
        'email': email,
        'password': password,
      });
      return LoginCertificate.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      Logger.print('Login error: $e');
      return Future.error(e);
    }
  }

  /// 邮箱注册（含验证码和昵称）。
  static Future<void> register({
    required String nickname,
    required String email,
    required String code,
    required String password,
  }) async {
    await HttpUtils.post(Urls.userRegister, data: {
      'user': nickname,
      'email': email,
      'verify_code': code,
      'password': password,
      'confirm': password,
    });
  }

  /// 重置密码。
  static Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    await HttpUtils.post(Urls.resetPasswd, data: {
      'email': email,
      'verify_code': code,
      'password': password,
      'confirm': password,
    });
  }

  // ============================================================
  // 验证码
  // ============================================================

  /// 发送邮箱验证码。
  ///
  /// [purpose]: 1=注册，2=重置密码，3=登录
  static Future<void> sendVerificationCode({
    required String email,
    int purpose = 1,
  }) async {
    await HttpUtils.post(Urls.getVerifyCode, data: {
      'email': email,
      'purpose': purpose,
    });
  }
}
