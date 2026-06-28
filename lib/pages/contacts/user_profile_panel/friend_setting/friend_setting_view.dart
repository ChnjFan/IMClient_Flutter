import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/styles/text_styles.dart';
import 'friend_setting_logic.dart';

class FriendSettingPage extends StatelessWidget {
  FriendSettingPage({super.key});

  final FriendSettingLogic logic = Get.find<FriendSettingLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('好友设置'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            children: [
              GetBuilder<FriendSettingLogic>(
                builder: (_) => _buildSwitchRow(
                  icon: Icons.star_outline_rounded,
                  label: '设为星标好友',
                  subtitle: '开启后该好友将显示在列表顶部',
                  value: logic.isStarred,
                  onChanged: (_) => logic.toggleStar(),
                ),
              ),
              _divider(),
              GetBuilder<FriendSettingLogic>(
                builder: (_) => _buildSwitchRow(
                  icon: Icons.block_outlined,
                  label: '加入黑名单',
                  subtitle: '加入黑名单后将无法收到对方消息',
                  value: logic.isBlacklisted,
                  onChanged: (_) => logic.toggleBlacklist(),
                ),
              ),
              _divider(),
              GetBuilder<FriendSettingLogic>(
                builder: (_) => _buildSwitchRow(
                  icon: Icons.do_not_disturb_alt_outlined,
                  label: '屏蔽好友消息',
                  subtitle: '屏蔽后将不再收到该好友的消息通知',
                  value: logic.isBlocked,
                  onChanged: (_) => logic.toggleBlock(),
                ),
              ),
              _divider(),
              GetBuilder<FriendSettingLogic>(
                builder: (_) => _buildSwitchRow(
                  icon: Icons.visibility_off_outlined,
                  label: '隐藏好友',
                  subtitle: '隐藏后该好友将不在列表中显示',
                  value: logic.isHidden,
                  onChanged: (_) => logic.toggleHidden(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            children: [
              _buildDestructiveRow(
                icon: Icons.person_remove_outlined,
                label: '删除联系人',
                onTap: () => _showDeleteConfirm(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---- UI components ----

  Widget _buildSection({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.c_0C1C33),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.ts_0C1C33_14sp),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.c_8E9AB0),
                ),
              ],
            ),
          ),
          _AppSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildDestructiveRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.c_FF381F.withValues(alpha: 0.06),
        highlightColor: AppColors.c_FF381F.withValues(alpha: 0.04),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // 红色调图标圆形容器
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.c_FF381F.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: AppColors.c_FF381F),
              ),
              const SizedBox(width: 12),
              // 标签
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.c_FF381F,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // 右侧箭头，暗示可点击
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.c_FF381F,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      indent: 50,
      endIndent: 16,
      color: AppColors.c_F0F2F6,
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 警告图标
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.c_FF381F.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person_remove_rounded,
                size: 26,
                color: AppColors.c_FF381F,
              ),
            ),
            const SizedBox(height: 16),
            // 标题
            const Text(
              '删除联系人',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.c_0C1C33,
              ),
            ),
            const SizedBox(height: 8),
            // 描述
            const Text(
              '删除后将无法恢复，确定删除该联系人吗？',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.c_8E9AB0,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              // 取消按钮
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: AppColors.c_E8EAEF),
                    foregroundColor: AppColors.c_0C1C33,
                  ),
                  child: const Text('取消', style: TextStyle(fontSize: 15)),
                ),
              ),
              const SizedBox(width: 12),
              // 删除按钮
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    logic.deleteContact();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: AppColors.c_FF381F,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('删除', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 自定义开关（与 setting_view.dart 中的 _AppSwitch 相同）
// ============================================================
class _AppSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AppSwitch({required this.value, required this.onChanged});

  @override
  State<_AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<_AppSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _thumbPosition;
  late Animation<Color?> _trackColor;

  static const double _trackWidth = 44;
  static const double _trackHeight = 24;
  static const double _thumbSize = 20;
  static const double _thumbPadding = 2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
    );
    _thumbPosition = Tween<double>(
      begin: 0,
      end: _trackWidth - _thumbSize - _thumbPadding * 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _trackColor = ColorTween(
      begin: AppColors.c_E8EAEF,
      end: AppColors.c_0089FF,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void didUpdateWidget(covariant _AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() => widget.onChanged(!widget.value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Container(
            width: _trackWidth,
            height: _trackHeight,
            decoration: BoxDecoration(
              color: _trackColor.value,
              borderRadius: BorderRadius.circular(_trackHeight / 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: _thumbPadding + _thumbPosition.value,
                  top: _thumbPadding,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: const BoxDecoration(
                      color: AppColors.c_FFFFFF,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
