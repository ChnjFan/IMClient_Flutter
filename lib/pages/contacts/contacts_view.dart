import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import 'friend_list/friend_list_view.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import 'contacts_logic.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final ContactsLogic logic = Get.find<ContactsLogic>();
  final IMController imController = Get.find<IMController>();

  static const double _menuCardTopMargin = 16;
  static const double _menuItemHeight = 56;
  static const int _menuItemCount = 3; // 新的朋友、群聊、标签

  double get _menuCardHeight =>
      _menuCardTopMargin + _menuItemCount * _menuItemHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.contacts),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_outlined,
                color: AppColors.c_0C1C33),
            onPressed: () => AppNavigator.startAddMethod(),
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

        final groups = logic.sortedGroupedFriends;
        final groupKeys = logic.sortedGroupKeys;

        return Column(
          children: [
            _buildMenuCard(),
            Expanded(
              child: FriendList(
                groups: groups,
                groupKeys: groupKeys,
                displayName: logic.displayName,
                topOffset: _menuCardHeight,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMenuCard() {
    return Container(
      margin:
          const EdgeInsets.only(top: _menuCardTopMargin, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Obx(() => _buildMenuItem(
                icon: Icons.person_add_alt_1_rounded,
                title: '新的朋友',
                badgeCount: imController.newFriendApplyCount.value,
                onTap: () {
                  imController.newFriendApplyCount.value = 0;
                  AppNavigator.startFriendApplys();
                },
              )),
          const Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: AppColors.c_F0F2F6,
          ),
          _buildMenuItem(
            icon: Icons.group_rounded,
            title: '群聊',
          ),
          const Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: AppColors.c_F0F2F6,
          ),
          _buildMenuItem(
            icon: Icons.label_rounded,
            title: '标签',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    int badgeCount = 0,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: _menuItemHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.c_0089FF_opacity10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: AppColors.c_0089FF),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: AppTextStyles.ts_0C1C33_14sp),
            ),
            if (badgeCount > 0)
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 99 ? '99+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const Icon(Icons.chevron_right,
                size: 20, color: AppColors.c_8E9AB0),
          ],
        ),
      ),
    );
  }
}
