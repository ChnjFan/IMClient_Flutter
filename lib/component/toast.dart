import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/styles/colors.dart';

/// 简约风格 Toast 提示组件。
///
/// 顶部浮动胶囊式提示，使用 APP 主色调区分消息类型。
class AppToast {
  AppToast._();

  static const _duration = Duration(seconds: 2);
  static const _borderRadius = 12.0;
  static const _margin = EdgeInsets.symmetric(horizontal: 24, vertical: 8);

  /// 普通信息提示。
  static void show(String msg) {
    _showSnackbar(
      msg: msg,
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.c_0089FF,
    );
  }

  /// 成功提示。
  static void success(String msg) {
    _showSnackbar(
      msg: msg,
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColors.c_10CC64,
    );
  }

  /// 错误提示。
  static void error(String msg) {
    _showSnackbar(
      msg: msg,
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.c_FF381F,
    );
  }

  /// 带标题的提示（标题为粗体，消息为副文本）。
  static void showWithTitle(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.c_FFFFFF,
      titleText: Text(
        title,
        style: const TextStyle(
          color: AppColors.c_0C1C33,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        msg,
        style: const TextStyle(
          color: AppColors.c_8E9AB0,
          fontSize: 13,
        ),
      ),
      margin: _margin,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      borderRadius: _borderRadius,
      boxShadows: _shadows,
      barBlur: 0,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  // ---- 内部 ----

  static void _showSnackbar({
    required String msg,
    required IconData icon,
    required Color iconColor,
  }) {
    Get.snackbar(
      '', // 标题留空，仅展示消息
      msg,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      duration: _duration,
      backgroundColor: AppColors.c_FFFFFF,
      icon: Icon(icon, color: iconColor, size: 22),
      shouldIconPulse: false,
      titleText: const SizedBox.shrink(),
      messageText: Text(
        msg,
        style: const TextStyle(
          color: AppColors.c_0C1C33,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      margin: _margin,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      borderRadius: _borderRadius,
      boxShadows: _shadows,
      barBlur: 0,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static const _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}
