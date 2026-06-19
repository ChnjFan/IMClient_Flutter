class UserInfo {
  String? userID;
  String? name;
  /// 备注
  String? remark;
  String? email;
  String? avatarUrl;
  String? ex;


  UserInfo({
    this.userID,
    this.name,
    this.remark,
    this.email,
    this.avatarUrl,
    this.ex,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userID: json['uid'],
      name: json['name'],
      remark: json['remark'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      ex: json['ex'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = userID;
    data['name'] = name;
    data['remark'] = remark;
    data['email'] = email;
    data['avatar'] = avatarUrl;
    data['ex'] = ex;
    return data;
  }

  /// 获取显示名称，优先级：备注 > 昵称 > 用户ID
  String getShowName() => _isNull(remark) ?? _isNull(name) ?? _isNull(userID) ?? '';
  /// 判断字符串空，返回空值
  static String? _isNull(String? str) => str == null || str.isEmpty ? null : str;
}