import 'package:get/get.dart';
import 'reset_passwd_logic.dart';

class ResetPasswdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswdLogic());
  }
}
