import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imclient_flutter/common/models/user/user_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/validators.dart';
import 'package:imclient_flutter/core/controller/im_controller.dart';

class SearchFriendLogic extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final keyword = ''.obs;
  final isSearching = false.obs;
  final isLoading = false.obs;
  final searchResult = Rx<UserInfo?>(null);

  final IMController imLogic = Get.find<IMController>();

  Future<void> onSearch() async {
    final text = searchController.text.trim();
    if (text.isEmpty) return;
    keyword.value = text;
    isSearching.value = true;
    isLoading.value = true;
    searchResult.value = null;

    try {
      // 根据输入类型调用不同的搜索方法
      UserInfo? userInfo;
      switch (Validators.identify(text)) {
        case InputType.email:
          userInfo = await imLogic.searchUserInfo(email: text);
          break;
        case InputType.phone:
        case InputType.numericId:
        case InputType.text:
          userInfo = await imLogic.searchUserInfo(nickname: text);
          break;
      }
      Logger.print('SearchFriend — keyword: $text, result: ${userInfo.toJson()}');
      searchResult.value = userInfo;
    } catch (e) {
      Logger.print('SearchFriend — error: $e');
      searchResult.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void onClear() {
    searchController.clear();
    keyword.value = '';
    isSearching.value = false;
    searchResult.value = null;
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
