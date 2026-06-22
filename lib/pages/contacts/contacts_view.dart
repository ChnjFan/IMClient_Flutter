import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/db/daos/friend_dao.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import 'contacts_logic.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final ContactsLogic logic = Get.find<ContactsLogic>();
  final IMController imController = Get.find<IMController>();

  // ---- 布局常量 ----
  static const double _menuCardTopMargin = 16;
  static const double _menuItemHeight = 56;
  static const int _menuItemCount = 3; // 新的朋友、群聊、标签
  static const double _sectionHeaderHeight = 40;
  static const double _contactItemHeight = 64;
  static const double _indexBarWidth = 24;

  /// 菜单卡片区域总高度。
  double get _menuCardHeight =>
      _menuCardTopMargin + _menuItemCount * _menuItemHeight;

  final ScrollController _scrollController = ScrollController();

  /// 每个分组字母对应的 section header 在 ListView 中的 GlobalKey。
  final Map<String, GlobalKey> _sectionKeys = {};

  /// 每个分组字母对应的滚动偏移量（预计算）。
  final Map<String, double> _letterOffsets = {};

  /// 当前高亮的索引字母（拖拽索引用）。
  final RxString _highlightedLetter = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
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

        // 为每个 section 准备 GlobalKey
        for (final key in groupKeys) {
          _sectionKeys.putIfAbsent(key, () => GlobalKey());
        }

        // 预计算每个字母对应的滚动偏移
        _computeOffsets(groupKeys, groups);

        return Stack(
          children: [
            // ---- 好友列表 ----
            ListView.builder(
              controller: _scrollController,
              itemCount: _totalItemCount(groupKeys, groups),
              itemBuilder: (context, index) {
                // 菜单卡片
                if (index == 0) {
                  return _buildMenuCard();
                }

                int runningIndex = 1;
                for (final groupKey in groupKeys) {
                  final members = groups[groupKey]!;

                  // Section header
                  if (index == runningIndex) {
                    return _buildSectionHeader(groupKey,
                        key: _sectionKeys[groupKey]);
                  }
                  runningIndex++;

                  // Contact items
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
            ),

            // ---- 右侧快速索引栏 ----
            Positioned(
              right: 2,
              top: 0,
              bottom: 0,
              child: _buildIndexBar(groupKeys),
            ),

            // ---- 索引导航浮层（拖拽时显示） ----
            Obx(() {
              if (_highlightedLetter.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.c_0C1C33.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      _highlightedLetter.value,
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
      }),
    );
  }

  // ---- 索引栏 ----
  static const double _indexLetterHeight = 15;

  Widget _buildIndexBar(List<String> existingKeys) {
    return GestureDetector(
      onVerticalDragStart: (details) =>
          _onIndexBarDrag(details.localPosition, existingKeys),
      onVerticalDragUpdate: (details) =>
          _onIndexBarDrag(details.localPosition, existingKeys),
      onVerticalDragEnd: (_) => _highlightedLetter.value = '',
      onTapUp: (details) =>
          _onIndexBarTap(details.localPosition, existingKeys),
      child: Container(
        width: _indexBarWidth,
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: ContactsLogic.indexLetters.map((letter) {
            final isActive = existingKeys.contains(letter);
            return SizedBox(
              height: _indexLetterHeight,
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: isActive
                        ? AppColors.c_0089FF
                        : AppColors.c_8E9AB0.withValues(alpha: 0.4),
                    fontSize: 11,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---- 索引栏交互 ----
  void _onIndexBarTap(Offset localPosition, List<String> existingKeys) {
    final letter = _getLetterAtPosition(localPosition);
    if (letter != null && existingKeys.contains(letter)) {
      _scrollToLetter(letter);
    }
  }

  void _onIndexBarDrag(Offset localPosition, List<String> existingKeys) {
    final letter = _getLetterAtPosition(localPosition);
    if (letter != null && letter != _highlightedLetter.value) {
      _highlightedLetter.value = letter;
      if (existingKeys.contains(letter)) {
        _scrollToLetter(letter);
      }
    }
  }

  /// 根据触摸位置计算对应的索引字母。
  String? _getLetterAtPosition(Offset localPosition) {
    final effectiveHeight = _indexBarEffectiveHeight;
    if (effectiveHeight <= 0) return null;

    final letterHeight = effectiveHeight / ContactsLogic.indexLetters.length;
    final index = (localPosition.dy / letterHeight).floor();
    if (index < 0 || index >= ContactsLogic.indexLetters.length) return null;
    return ContactsLogic.indexLetters[index];
  }

  double get _indexBarEffectiveHeight =>
      ContactsLogic.indexLetters.length * _indexLetterHeight;

  /// 滚动到指定字母对应的 section。
  void _scrollToLetter(String letter) {
    final offset = _letterOffsets[letter];
    if (offset != null && _scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final targetOffset = offset.clamp(0.0, maxScroll);
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  // ---- 偏移量计算 ----
  void _computeOffsets(
      List<String> groupKeys, Map<String, List<FriendWithProfile>> groups) {
    _letterOffsets.clear();
    double offset = _menuCardHeight;
    for (final groupKey in groupKeys) {
      _letterOffsets[groupKey] = offset;
      offset += _sectionHeaderHeight;
      offset += (groups[groupKey]?.length ?? 0) * _contactItemHeight;
    }
  }

  int _totalItemCount(
      List<String> groupKeys, Map<String, List<FriendWithProfile>> groups) {
    int count = 1; // menu card
    for (final groupKey in groupKeys) {
      count++; // section header
      count += groups[groupKey]!.length;
    }
    return count;
  }

  // ---- UI 构建方法 ----

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
          // 新的朋友 — 单独处理，需要 Obx 监听红点计数
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

  Widget _buildSectionHeader(String title, {Key? key}) {
    return Container(
      key: key,
      width: double.infinity,
      height: _sectionHeaderHeight,
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
    final name = logic.displayName(item);
    final avatarUrl = item.profile?.avatarUrl ?? '';

    return InkWell(
      onTap: () => AppNavigator.startUserProfilePanel(
        userInfo: item.friend.userId,
      ),
      child: Column(
        children: [
          Container(
            height: _contactItemHeight,
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
                            errorBuilder: (_, _, _) =>
                                _buildAvatarPlaceholder(),
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
      ),
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
