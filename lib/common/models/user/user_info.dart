class UserInfo {
  String? uid;
  String? name;
  /// 备注
  String? alias;
  String? email;
  String? avatarUrl;
  String? ex;


  UserInfo({
    this.uid,
    this.name,
    this.alias,
    this.email,
    this.avatarUrl,
    this.ex,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      uid: json['uid'].toString(),
      name: json['name'],
      alias: json['alias'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      ex: json['ex'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['alias'] = alias;
    data['email'] = email;
    data['avatar'] = avatarUrl;
    data['ex'] = ex;
    return data;
  }

  /// 获取显示名称，优先级：备注 > 昵称 > 用户ID
  String getShowName() => _isNull(alias) ?? _isNull(name) ?? _isNull(uid) ?? '';
  /// 判断字符串空，返回空值
  static String? _isNull(String? str) => str == null || str.isEmpty ? null : str;
}