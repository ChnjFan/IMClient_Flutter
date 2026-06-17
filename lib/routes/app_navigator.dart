import 'package:get/get.dart';
import 'app_pages.dart';

/// Centralized navigation helper.
/// All page transitions should go through this class.
class AppNavigator {
  AppNavigator._();

  /// Navigate to login and clear the entire stack.
  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  /// Navigate to home and clear the entire stack.
  static void startMain({bool isAutoLogin = false}) {
    Get.offAllNamed(
      AppRoutes.home,
      arguments: {'isAutoLogin': isAutoLogin},
    );
  }

  /// Navigate from splash to main (no back to splash).
  static void startSplashToMain({bool isAutoLogin = false}) {
    Get.offAndToNamed(
      AppRoutes.home,
      arguments: {'isAutoLogin': isAutoLogin},
    );
  }

  /// Go back until home is reached.
  static void startBackMain() {
    Get.until((route) => Get.currentRoute == AppRoutes.home);
  }

  /// Navigate to register page.
  static void startRegister() {
    Get.toNamed(AppRoutes.register);
  }

  /// Navigate to forget password page.
  static void startForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }
}
