import 'dart:async';
import 'package:get/get.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/storage.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';

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
    // Add a small delay so the splash screen is visible
    await Future.delayed(const Duration(seconds: 2));

    final uid = await Storage.userID;
    final tkn = await Storage.token;

      AppNavigator.startLogin();
    return;

    if (uid != null && uid.isNotEmpty && tkn != null && tkn.isNotEmpty) {
      Logger.print('SplashLogic — found stored credentials, auto-login...');
      try {
        await imLogic.login(uid, tkn);
        Logger.print('SplashLogic — auto-login success');
        AppNavigator.startSplashToMain(isAutoLogin: true);
      } catch (e) {
        Logger.print('SplashLogic — auto-login failed: $e');
        await Storage.removeLoginCertificate();
        AppNavigator.startLogin();
      }
    } else {
      Logger.print('SplashLogic — no stored credentials, go to login');
      AppNavigator.startLogin();
    }
  }

  @override
  void onClose() {
    _initializedSub.cancel();
    super.onClose();
  }
}
