import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 统一 Toast/Snackbar 提示组件。
///
/// 所有应用内轻提示都应通过此类调用，避免各处重复样式代码。
class AppToast {
  AppToast._();

  static const _bgColor = Colors.black87;
  static const _textColor = Colors.white;
  static const _margin = EdgeInsets.all(16);
  static const _duration = Duration(seconds: 2);

  /// 纯消息提示（无标题，底部显示）。
  static void show(String msg) {
    Get.snackbar('', msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: _duration,
        backgroundColor: _bgColor,
        colorText: _textColor,
        margin: _margin,
        borderRadius: 8);
  }

  /// 成功提示。
  static void success(String msg) {
    Get.snackbar('', msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: _duration,
        backgroundColor: _bgColor,
        colorText: _textColor,
        margin: _margin,
        borderRadius: 8);
  }

  /// 失败/错误提示。
  static void error(String msg) {
    Get.snackbar('', msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: _duration,
        backgroundColor: _bgColor,
        colorText: _textColor,
        margin: _margin,
        borderRadius: 8);
  }

  /// 带标题的提示。
  static void showWithTitle(String title, String msg) {
    Get.snackbar(title, msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: _duration,
        backgroundColor: _bgColor,
        colorText: _textColor,
        margin: _margin,
        borderRadius: 8);
  }
}
