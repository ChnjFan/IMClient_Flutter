import '../config.dart';

class Urls {
  static final getVerifyCode = "${AppConfig.gateServerUrl}/get_verify_code";
  static final userRegister = "${AppConfig.gateServerUrl}/user_register";
  static final resetPasswd = "${AppConfig.gateServerUrl}/reset_passwd";
  static final userLogin = "${AppConfig.gateServerUrl}/user_login";
}
