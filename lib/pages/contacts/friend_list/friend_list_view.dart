import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/db/daos/friend_dao.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../routes/app_navigator.dart';
import 'friend_list_logic.dart';

class FriendList extends StatelessWidget {
  final Map<String, List<FriendWithProfile>> groups;
  final List<String> groupKeys;
  final String Function(FriendWithProfile) displayName;
  final double topOffset;

  const FriendList({
    super.key,
    required this.groups,
    required this.groupKeys,
    required this.displayName,
    this.topOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FriendListLogic(), permanent: false);
    logic.groups = groups;
    logic.groupKeys = groupKeys;
    logic.displayName = displayName;
    logic.topOffset = topOffset;
    logic.computeOffsets();

    return Stack(
      children: [
        ListView.builder(
          controller: logic.scrollController,
          itemCount: logic.totalItemCount(),
          itemBuilder: (context, index) {
            int runningIndex = 0;
            for (final groupKey in logic.groupKeys) {
              final members = logic.groups[groupKey]!;

              if (index == runningIndex) {
                return _buildSectionHeader(groupKey,
                    key: logic.sectionKeys[groupKey]);
              }
              runningIndex++;

              if (index < runningIndex + members.length) {
                final memberIndex = index - runningIndex;
                final isLast = memberIndex == members.length - 1;
                return _buildContactItem(
                    logic,
                    members[memberIndex],
                    isLast: isLast);
              }
              runningIndex += members.length;
            }
            return const SizedBox.shrink();
          },
        ),

        // 右侧快速索引栏
        Positioned(
          right: 2,
          top: 0,
          bottom: 0,
          child: _buildIndexBar(logic),
        ),

        // 索引导航浮层
        Obx(() {
          if (logic.highlightedLetter.value.isEmpty) {
            return const SizedBox.shrink();
          }
          return Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.c_0C1C33.withAlpha(179),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  logic.highlightedLetter.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ---- 索引栏 ----

  Widget _buildIndexBar(FriendListLogic logic) {
    return GestureDetector(
      onVerticalDragStart: (d) => logic.onIndexBarDrag(d.localPosition),
      onVerticalDragUpdate: (d) => logic.onIndexBarDrag(d.localPosition),
      onVerticalDragEnd: (_) => logic.clearHighlight(),
      onTapUp: (d) => logic.onIndexBarTap(d.localPosition),
      child: Container(
        width: FriendListLogic.indexBarWidth,
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: contactsIndexLetters.map((letter) {
            final isActive = logic.groupKeys.contains(letter);
            return SizedBox(
              height: FriendListLogic.indexLetterHeight,
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: isActive
                        ? AppColors.c_0089FF
                        : AppColors.c_8E9AB0.withAlpha(102),
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---- UI 构建 ----

  Widget _buildSectionHeader(String title, {Key? key}) {
    return Container(
      key: key,
      width: double.infinity,
      height: FriendListLogic.sectionHeaderHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.c_F0F2F6,
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTextStyles.ts_8E9AB0_12sp),
    );
  }

  Widget _buildContactItem(
      FriendListLogic logic, FriendWithProfile item, {bool isLast = false}) {
    final name = logic.displayName(item);
    final avatarUrl = item.profile?.avatarUrl ?? '';

    return InkWell(
      onTap: () => AppNavigator.startUserProfilePanel(
        userInfo: item.friend.userId,
      ),
      child: Column(
        children: [
          Container(
            height: FriendListLogic.contactItemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.c_FFFFFF,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: avatarUrl.isNotEmpty
                        ? Image.network(
                            avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                _buildAvatarPlaceholder(),
                          )
                        : _buildAvatarPlaceholder(),
                  ),
                ),
                const SizedBox(width: 12),
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
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.c_0089FF_opacity10,
      child: const Icon(Icons.person, size: 28, color: AppColors.c_0089FF),
    );
  }
}
