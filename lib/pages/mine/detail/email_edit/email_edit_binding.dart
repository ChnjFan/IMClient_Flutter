import 'package:get/get.dart';
import 'email_edit_logic.dart';

class EmailEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailEditLogic());
  }
}
