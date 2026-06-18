import 'package:get/get.dart';
import '../mine/mine_logic.dart';
import 'home_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => MineLogic());
  }
}
