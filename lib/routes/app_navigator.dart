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

  /// Navigate to phone edit page.
  static Future<T?>? startPhoneEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.phoneEdit);
  }

  /// Navigate to signature edit page.
  static Future<T?>? startSignatureEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.signatureEdit);
  }

  /// Navigate to self intro edit page.
  static Future<T?>? startSelfIntroEdit<T extends Object?>() {
    return Get.toNamed(AppRoutes.selfIntroEdit);
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

  /// Navigate to alias edit page (修改备注).
  static Future<T?>? startAliasEdit<T extends Object?>({
    required String friendId,
    required String alias,
  }) {
    return Get.toNamed(
      AppRoutes.aliasEdit,
      arguments: {'friendId': friendId, 'alias': alias},
    );
  }

  /// Navigate to apply friend page.
  static Future<T?>? startApplyFriend<T extends Object?>({
    required dynamic userInfo,
  }) {
    return Get.toNamed(AppRoutes.applyFriend, arguments: userInfo);
  }

  /// Navigate to friend applys (好友请求列表) page.
  static Future<T?>? startFriendApplys<T extends Object?>() {
    return Get.toNamed(AppRoutes.friendApplys);
  }

  /// Navigate to process apply (处理好友申请) page.
  static Future<T?>? startProcessApply<T extends Object?>({
    required dynamic item,
  }) {
    return Get.toNamed(AppRoutes.processApply, arguments: item);
  }

  /// Navigate to friend setting page.
  static Future<T?>? startFriendSetting<T extends Object?>() {
    return Get.toNamed(AppRoutes.friendSetting);
  }

  /// Navigate to setting page.
  static Future<T?>? startSetting<T extends Object?>() {
    return Get.toNamed(AppRoutes.setting);
  }

  /// Navigate to chat page.
  static Future<T?>? startChat<T extends Object?>({
    required String convId,
    dynamic targetUser,
  }) {
    return Get.toNamed(
      AppRoutes.chat,
      arguments: {'convId': convId, 'targetUser': targetUser},
    );
  }
}
