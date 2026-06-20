import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/styles/text_styles.dart';
import '../../../../common/widgets/user_info_view.dart';
import 'search_friend_logic.dart';

class SearchFriendPage extends StatelessWidget {
  SearchFriendPage({super.key});

  final SearchFriendLogic logic = Get.find<SearchFriendLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: 36,
            child: TextField(
              controller: logic.searchController,
              focusNode: logic.searchFocusNode,
              autofocus: true,
              style: const TextStyle(fontSize: 13, color: AppColors.c_333333),
              decoration: InputDecoration(
                hintText: '输入 ID / 手机号 / 邮箱',
                hintStyle: AppTextStyles.ts_8E9AB0_12sp,
                filled: true,
                fillColor: AppColors.c_F0F2F6,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.c_8E9AB0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Obx(() => logic.keyword.value.isNotEmpty
                    ? GestureDetector(
                        onTap: logic.onClear,
                        child: const Icon(Icons.cancel, size: 18, color: AppColors.c_8E9AB0),
                      )
                    : const SizedBox.shrink()),
              ),
              onChanged: (_) => logic.keyword.value = logic.searchController.text.trim(),
              onSubmitted: (_) => logic.onSearch(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (logic.keyword.value.isNotEmpty) {
                logic.onSearch();
              } else {
                Get.back();
              }
            },
            child: const Text(
              '搜索',
              style: TextStyle(
                fontSize: 15,
                color: AppColors.c_0089FF,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (logic.isLoading.value) {
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.c_0089FF,
              ),
            ),
          );
        }

        if (!logic.isSearching.value) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_search_rounded,
                  size: 64,
                  color: AppColors.c_0089FF_opacity10,
                ),
                SizedBox(height: 16),
                Text(
                  '输入 ID / 手机号 / 邮箱搜索好友',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.c_8E9AB0,
                  ),
                ),
              ],
            ),
          );
        }

        final result = logic.searchResult.value;
        if (result == null) {
          return const Center(
            child: Text(
              '未找到该用户',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.c_8E9AB0,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              UserInfoView(
                nickname: result.getShowName(),
                email: result.email ?? '',
                avatarUrl: result.avatarUrl ?? '',
                onTap: () {
                  // TODO: 跳转到用户详情页
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
