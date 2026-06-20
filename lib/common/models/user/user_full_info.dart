import 'package:flutter/material.dart';

import 'user_info.dart';

/// 用户详细信息模型。
///
/// 继承 [UserInfo]，补充详细资料和社交关系字段，
/// 用于用户详情页展示。
class UserFullInfo extends UserInfo {
  /// 手机号
  String? phone;
  /// 性别：0=未知, 1=男, 2=女
  int? gender;
  /// 生日（yyyy-MM-dd）
  String? birthday;
  /// 个性签名
  String? signature;
  /// 地区
  String? region;
  /// 好友状态：0=非好友, 1=正常好友, 2=已拉黑
  int? friendStatus;
  /// 个人简介
  String? selfIntro;
  
  /// 用户设置
  /// 隐私设置：好友设置 0-禁止添加好友，1-需要验证，2-直接添加
  int? privacyFriend;
  /// 隐私设置：聊天设置 0-禁止陌生人聊天，1-需要验证，2-直接聊天
  int? privacyChat;
  /// 隐私设置：黑名单设置 0-关闭，1-开启
  int? privacyBlacklist;

  String? createTime;
  String? updateTime;

  UserFullInfo({
    super.userID,
    super.name,
    super.remark,
    super.email,
    super.avatarUrl,
    super.ex,
    this.phone,
    this.gender,
    this.birthday,
    this.signature,
    this.region,
    this.friendStatus,
    this.selfIntro,
    this.privacyFriend,
    this.privacyChat,
    this.privacyBlacklist,
    this.createTime,
    this.updateTime,
  });

  factory UserFullInfo.fromJson(Map<String, dynamic> json) {
    return UserFullInfo(
      userID: json['uid']?.toString(),
      name: json['name'],
      remark: json['remark'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      ex: json['ex'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      signature: json['signature'],
      region: json['region'],
      friendStatus: json['friend_status'],
      selfIntro: json['self_intro'],
      privacyFriend: json['privacy_friend'],
      privacyChat: json['privacy_chat'],
      privacyBlacklist: json['privacy_blacklist'],
      createTime: json['create_time'],
      updateTime: json['update_time'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['phone'] = phone;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['signature'] = signature;
    data['region'] = region;
    data['friend_status'] = friendStatus;
    data['self_intro'] = selfIntro;
    data['privacy_friend'] = privacyFriend;
    data['privacy_chat'] = privacyChat;
    data['privacy_blacklist'] = privacyBlacklist;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    return data;
  }

  /// 性别文本
  String get genderText {
    switch (gender) {
      case 1:
        return '男';
      case 2:
        return '女';
      default:
        return '未设置';
    }
  }

  /// 性别图标颜色
  Color get genderColor {
    switch (gender) {
      case 1:
        return const Color(0xFF4A90D9);
      case 2:
        return const Color(0xFFE8829A);
      default:
        return const Color(0xFF8E9AB0);
    }
  }

  /// 性别图标
  IconData get genderIcon {
    switch (gender) {
      case 1:
        return Icons.male_rounded;
      case 2:
        return Icons.female_rounded;
      default:
        return Icons.help_outline;
    }
  }
}