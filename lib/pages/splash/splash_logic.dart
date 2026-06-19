import 'dart:async';
import 'package:get/get.dart';
import '../../common/models/login_certificate.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import '../../common/db/database.dart';

class SplashLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late StreamSubscription<bool> _initializedSub;

  @override
  void onInit() {
    super.onInit();

    // Listen for IM SDK initialization completion
    _initializedSub = imLogic.initializedSubject.stream.listen((initialized) {
      if (initialized) {
        _checkLoginState();
      }
    });

    // If already initialized, check immediately
    if (imLogic.isInitialized) {
      _checkLoginState();
    }
  }

  Future<void> _checkLoginState() async {
    /// test 测试用延时，模拟加载过程
    await Future.delayed(const Duration(seconds: 2));

    final db = Get.find<AppDatabase>();
    final credential = await db.credentialDao.getLatest();

    if (credential != null &&
      credential.userId.isNotEmpty &&
      credential.token.isNotEmpty) {
      // 有凭证，自动登录
      try {
        final cert = LoginCertificate(
          userId: credential.userId,
          chatToken: credential.token,
          chatServerIp: credential.serverHost ?? '',
        );
        Logger.print('SplashLogic — found stored credentials, auto-login...');
        await imLogic.login(cert);
        AppNavigator.startSplashToMain(isAutoLogin: true);
      } catch (e) {
        await db.credentialDao.clear();
        Logger.print('SplashLogic — auto-login failed: $e');
        AppNavigator.startLogin();
      }
    } else {
      Logger.print('SplashLogic — no stored credentials, go to login');
      /// test 测试用，直接进入主页
      // AppNavigator.startSplashToMain(isAutoLogin: true);
      AppNavigator.startLogin();
    }
  }

  @override
  void onClose() {
    _initializedSub.cancel();
    super.onClose();
  }
}
