import 'package:flutter/material.dart';

/// 统一管理 assets/images 下的图片资源和 Material Icon 图标引用。
///
/// 使用方式：
/// ```dart
/// // 显示资源图片
/// Image.asset(AppImages.loginBackground, width: 200)
/// // 或 SVG 图片
/// SvgPicture.asset(AppImages.loginBackground, width: 200)
/// ```
class AppImages {
  AppImages._();

  // ---- 资源图片路径 ----

  /// 登录页顶部背景插图 (SVG)
  static const String loginBackground = 'assets/images/login_background.svg';

  // ---- Material Icon 图标 ----

  /// 启动页 Logo
  static const IconData splashLogo = Icons.chat_bubble_rounded;

  // ---- 主页底部导航图标 ----

  static const IconData homeTabNor = Icons.chat_bubble_outline;
  static const IconData homeTabSel = Icons.chat_bubble;
  static const IconData contactsTabNor = Icons.contacts_outlined;
  static const IconData contactsTabSel = Icons.contacts;
  static const IconData mineTabNor = Icons.person_outline;
  static const IconData mineTabSel = Icons.person;
}
