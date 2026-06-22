import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/apis.dart';
import '../../common/utils/logger.dart';

class ResetPasswdLogic extends GetxController {
  final emailCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final confirmPwdCtrl = TextEditingController();

  final obscureText = true.obs;
  final enabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailCtrl.addListener(_onChanged);
    codeCtrl.addListener(_onChanged);
    pwdCtrl.addListener(_onChanged);
    confirmPwdCtrl.addListener(_onChanged);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    codeCtrl.dispose();
    pwdCtrl.dispose();
    confirmPwdCtrl.dispose();
    super.onClose();
  }

  void _onChanged() {
    enabled.value = emailCtrl.text.trim().isNotEmpty &&
        codeCtrl.text.trim().isNotEmpty &&
        pwdCtrl.text.trim().isNotEmpty &&
        confirmPwdCtrl.text.trim().isNotEmpty;
  }

  Future<bool> getVerificationCode() async {
    final email = emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      _showToast('请输入正确的邮箱');
      return false;
    }
    try {
      await ApiService.sendVerificationCode(email: email, purpose: 2);
      _showToast('验证码已发送');
      return true;
    } catch (e) {
      _showToast('发送失败，请重试');
      return false;
    }
  }

  Future<void> resetPassword() async {
    final email = emailCtrl.text.trim();
    final password = pwdCtrl.text.trim();
    final confirm = confirmPwdCtrl.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      _showToast('请输入正确的邮箱');
      return;
    }
    if (password.length < 6) {
      _showToast('密码至少 6 位');
      return;
    }
    if (password != confirm) {
      _showToast('两次密码不一致');
      return;
    }

    try {
      Logger.print('Reset password — email: $email');

      await ApiService.resetPassword(
        email: email,
        code: codeCtrl.text.trim(),
        password: password,
      );

      Get.back();
      _showToast('密码重置成功，请登录');
    } catch (e) {
      Logger.print('Reset password error: $e');
      if (e is (int, String)) {
        _showToast(e.$2);
      } else {
        _showToast('重置失败，请重试');
      }
    }
  }

  void _showToast(String msg) => AppToast.show(msg);
}
