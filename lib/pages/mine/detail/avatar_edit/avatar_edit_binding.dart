import 'package:get/get.dart';
import 'avatar_edit_logic.dart';

class AvatarEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvatarEditLogic());
  }
}
