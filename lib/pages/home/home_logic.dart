import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final index = 0.obs;

  void switchTab(int idx) {
    index.value = idx;
  }
}
