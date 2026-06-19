import 'package:get/get.dart';
import '../../core/controller/im_controller.dart';

class MineLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  String get nickname => imLogic.userInfo.value.name ?? '';
  String get email => imLogic.userInfo.value.email ?? '';
  String get avatarUrl => imLogic.userInfo.value.avatarUrl ?? '';
}
