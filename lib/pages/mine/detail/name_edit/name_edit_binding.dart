import 'package:get/get.dart';
import 'name_edit_logic.dart';

class NameEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NameEditLogic());
  }
}
