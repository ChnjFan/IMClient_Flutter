import 'package:get/get.dart';
import 'phone_edit_logic.dart';

class PhoneEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneEditLogic());
  }
}
