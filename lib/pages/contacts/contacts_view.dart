import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/db/daos/friend_dao.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../routes/app_navigator.dart';
import 'contacts_logic.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final ContactsLogic logic = Get.find<ContactsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(AppStrings.contacts),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_outlined, color: AppColors.c_0C1C33),
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

        final groups = logic.groupedFriends;
        final groupNames = groups.keys.toList();
        final headerItemCount = 1; // 菜单卡片

        int totalItemCount() {
          int count = headerItemCount;
          for (final groupName in groupNames) {
            count++; // section header
            count += groups[groupName]!.length;
          }
          return count;
        }

        return ListView.builder(
          itemCount: totalItemCount(),
          itemBuilder: (context, index) {
            // Fixed header menu card
            if (index < headerItemCount) {
              return _buildMenuCard();
            }

            // Friend list section
            int runningIndex = headerItemCount;
            for (final groupName in groupNames) {
              final members = groups[groupName]!;

              if (index == runningIndex) {
                return _buildSectionHeader(groupName);
              }
              runningIndex++;

              if (index < runningIndex + members.length) {
                final memberIndex = index - runningIndex;
                final isLast = memberIndex == members.length - 1;
                return _buildContactItem(members[memberIndex],
                    isLast: isLast);
              }
              runningIndex += members.length;
            }
            return const SizedBox.shrink();
          },
        );
      }),
    );
  }

  Widget _buildMenuCard() {
    final items = [
      {'icon': Icons.person_add_alt_1_rounded, 'title': '新的朋友'},
      {'icon': Icons.group_rounded, 'title': '群聊'},
      {'icon': Icons.label_rounded, 'title': '标签'},
    ];

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildMenuItem(
              icon: items[i]['icon'] as IconData,
              title: items[i]['title'] as String,
            ),
            if (i < items.length - 1)
              const Divider(
                height: 1,
                indent: 68,
                endIndent: 16,
                color: AppColors.c_F0F2F6,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
  }) {
    return InkWell(
      onTap: () {
        // TODO: 跳转到对应页面
      },
      child: Container(
        height: 56,
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
            const Icon(Icons.chevron_right, size: 20, color: AppColors.c_8E9AB0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.c_F0F2F6,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.ts_8E9AB0_12sp,
      ),
    );
  }

  Widget _buildContactItem(FriendWithProfile item, {bool isLast = false}) {
    final profile = item.profile;
    final name = profile?.name ??
        item.friend.remark ??
        item.friend.userId;
    final avatarUrl = profile?.avatarUrl ?? '';

    return Column(
      children: [
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: AppColors.c_FFFFFF,
          child: Row(
            children: [
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: avatarUrl.isNotEmpty
                      ? Image.network(
                          avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _buildAvatarPlaceholder(),
                        )
                      : _buildAvatarPlaceholder(),
                ),
              ),
              const SizedBox(width: 12),
              // Name
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.ts_0C1C33_14sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 76,
            endIndent: 16,
            color: AppColors.c_F0F2F6,
          ),
      ],
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.c_0089FF_opacity10,
      child: const Icon(
        Icons.person,
        size: 28,
        color: AppColors.c_0089FF,
      ),
    );
  }
}
