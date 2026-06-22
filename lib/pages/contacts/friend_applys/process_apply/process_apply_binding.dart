import 'package:get/get.dart';
import 'process_apply_logic.dart';

class ProcessApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProcessApplyLogic());
  }
}
