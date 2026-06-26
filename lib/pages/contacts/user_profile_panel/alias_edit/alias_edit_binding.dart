import 'package:get/get.dart';
import 'alias_edit_logic.dart';

class AliasEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AliasEditLogic());
  }
}
