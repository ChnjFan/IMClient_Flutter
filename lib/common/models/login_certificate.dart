import 'dart:convert';

/// 登录成功后服务端返回的凭证。
///
/// ```json
/// {
///   "uid": 123456,
///   "token": "eyJ...",
///   "user": "ChnjFan",
///   "email": "user@example.com",
///   “avatar_url“: "/path/avatar.svg"
///   "host": "192.168.1.1",
///   "port": "12345"
/// }
/// ```
class LoginCertificate {
  /// Chat 服务 Token
  String chatToken;
  /// Chat 服务地址
  String chatServerIp;
  String chatServerPort;
  // 用户信息
  String userId;
  String nickname;
  String email;
  String avatarUrl;

  LoginCertificate({
    this.userId = '-1',
    this.chatToken = '',
    this.chatServerIp = '',
    this.chatServerPort = '0',
    this.nickname = '',
    this.email = '',
    this.avatarUrl = '',
  });

  factory LoginCertificate.fromJson(Map<String, dynamic> map) {
    return LoginCertificate(
      userId: map['uid'] ?? '-1',
      chatToken: map['token'] ?? '',
      chatServerIp: map['host'] ?? '',
      chatServerPort: map['port'] ?? '0',
      nickname: map['user'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': userId,
      'token': chatToken,
      'host': chatServerIp,
      'port': chatServerPort,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
