import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/storage.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';

class LoginLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  // Controllers
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  // Reactive state
  final obscureText = true.obs;
  final enabled = false.obs;
  final versionInfo = ''.obs;

  // Focus nodes
  final emailFocus = FocusNode();
  final pwdFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    _initData();
    emailCtrl.addListener(_onChanged);
    pwdCtrl.addListener(_onChanged);
  }

  @override
  void onReady() {
    super.onReady();
    _getPackageInfo();
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    pwdCtrl.dispose();
    emailFocus.dispose();
    pwdFocus.dispose();
    super.onClose();
  }

  Future<void> _initData() async {
    final map = await Storage.getLoginAccount();
    if (map != null) {
      final email = map['email'] as String?;
      if (email != null && email.isNotEmpty) {
        emailCtrl.text = email;
      }
    }
  }

  void _onChanged() {
    enabled.value = emailCtrl.text.trim().isNotEmpty &&
        pwdCtrl.text.trim().isNotEmpty;
  }

  // ---- Actions ----

  Future<void> login() async {
    try {
      final email = emailCtrl.text.trim();
      if (email.isEmpty || !email.contains('@')) {
        _showToast('请输入正确的邮箱');
        return;
      }

      Logger.print('Login — email: $email');

      // Simulate API login
      await Future.delayed(const Duration(milliseconds: 500));

      final mockUserID = 'user_${DateTime.now().millisecondsSinceEpoch}';
      final mockToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

      // Save credentials
      await Storage.putLoginCertificate(
        userID: mockUserID,
        token: mockToken,
      );
      await Storage.setLoginAccount({
        'email': email,
        'loginType': 1, // email
      });

      // IM login
      await imLogic.login(mockUserID, mockToken);

      Logger.print('Login success — navigating to home');
      AppNavigator.startMain();
    } catch (e) {
      Logger.print('Login error: $e');
      _showToast('登录失败，请重试');
    }
  }

  void registerNow() => AppNavigator.startRegister();
  void forgetPassword() => AppNavigator.startForgetPassword();

  Future<void> _getPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      versionInfo.value =
          '${info.appName} ${info.version}+${info.buildNumber}';
    } catch (_) {
      versionInfo.value = 'IMClient 1.0.0+1';
    }
  }

  void _showToast(String msg) {
    Get.snackbar('', msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8);
  }
}
