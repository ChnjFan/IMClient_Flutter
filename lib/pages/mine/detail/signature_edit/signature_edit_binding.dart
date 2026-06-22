import 'package:get/get.dart';
import 'signature_edit_logic.dart';

class SignatureEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignatureEditLogic());
  }
}
