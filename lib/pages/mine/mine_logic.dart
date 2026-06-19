import 'package:get/get.dart';
import '../../core/controller/im_controller.dart';

class MineLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  String get nickname => imLogic.nickname.value;
  String get email => imLogic.email.value;
  String get avatarUrl => imLogic.avatarUrl.value;
}
