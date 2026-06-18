import 'package:get/get.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';

class MineLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  String get nickname => imLogic.nickname.value;
  String get userId => imLogic.userID.value;
  String get email => imLogic.email.value;

  /// 退出登录
  Future<void> logout() async {
    await imLogic.logout();
    AppNavigator.startLogin();
  }
}
