import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../common/apis.dart';
import '../../common/db/database.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';

class LoginLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  final AppDatabase _db = Get.find<AppDatabase>();

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
    final credential = await _db.credentialDao.getLatest();
    if (credential != null && credential.email != null) {
      emailCtrl.text = credential.email!;
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

      final cert = await ApiService.login(
        email: email,
        password: pwdCtrl.text.trim(),
      );

      // IM login
      await imLogic.login(cert);

      // 保存登录凭证到本地数据库，供下次自动登录
      await _db.credentialDao.save(
        userId: cert.userId,
        token: cert.chatToken,
        email: imLogic.userInfo.value.email,
        serverHost: cert.chatServerIp,
        serverPort: cert.chatServerPort,
        phoneNumber: imLogic.userInfo.value.email,
      );

      Logger.print('Login success — navigating to home');
      AppNavigator.startMain();
    } catch (e) {
      Logger.print('Login error: $e');
      if (e is (int, String)) {
        _showToast(e.$2);
      } else {
        _showToast('登录失败，请重试');
      }
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

  void _showToast(String msg) => AppToast.show(msg);
}
