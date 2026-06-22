import 'package:get/get.dart';
import 'self_intro_edit_logic.dart';

class SelfIntroEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelfIntroEditLogic());
  }
}
