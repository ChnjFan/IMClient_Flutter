import 'package:get/get.dart';
import 'add_method_logic.dart';

class AddMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMethodLogic());
  }
}
