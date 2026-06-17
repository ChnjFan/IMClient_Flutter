import 'dart:convert';

/// 登录成功后服务端返回的凭证。
///
/// ```json
/// {
///   "userID": "123456",
///   "imToken": "eyJ...",
///   "chatToken": "eyJ..."
/// }
/// ```
class LoginCertificate {
  /// 用户 ID
  String userID;

  /// Chat 服务 Token
  String chatToken;
  /// Chat 服务地址
  String chatAddr;

  LoginCertificate({
    this.userID = '',
    this.chatToken = '',
    this.chatAddr = '',
  });

  factory LoginCertificate.fromJson(Map<String, dynamic> map) {
    return LoginCertificate(
      userID: map['userID'] ?? '',
      chatToken: map['chatToken'] ?? '',
      chatAddr: map['chatAddr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'chatToken': chatToken,
      'chatAddr': chatAddr,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
