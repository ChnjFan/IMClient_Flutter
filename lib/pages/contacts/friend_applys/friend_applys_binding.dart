import 'package:get/get.dart';
import 'friend_applys_logic.dart';

class FriendApplysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendApplysLogic());
  }
}
