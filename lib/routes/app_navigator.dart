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

  /// Navigate to user detail page.
  static void startUserDetail() {
    Get.toNamed(AppRoutes.userDetail);
  }

  /// Navigate to name edit page.
  static Future<T?>? startNameEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.nameEdit);
  }

  /// Navigate to email edit page.
  static Future<T?>? startEmailEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.emailEdit);
  }

  /// Navigate to avatar edit page.
  static Future<T?>? startAvatarEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.avatarEdit);
  }

  /// Navigate to about page.
  static Future<T?>? startAbout<T extends Object?>() {
    return Get.toNamed(AppRoutes.about);
  }

  /// Navigate to add method page.
  static Future<T?>? startAddMethod<T extends Object?>() {
    return Get.toNamed(AppRoutes.addMethod);
  }

  /// Navigate to search friend page.
  static Future<T?>? startSearchFriend<T extends Object?>() {
    return Get.toNamed(AppRoutes.searchFriend);
  }

  /// Navigate to user profile panel page.
  static Future<T?>? startUserProfilePanel<T extends Object?>({
    required dynamic userInfo,
  }) {
    return Get.toNamed(AppRoutes.userProfilePanel, arguments: userInfo);
  }

  /// Navigate to apply friend page.
  static Future<T?>? startApplyFriend<T extends Object?>({
    required dynamic userInfo,
  }) {
    return Get.toNamed(AppRoutes.applyFriend, arguments: userInfo);
  }
}
