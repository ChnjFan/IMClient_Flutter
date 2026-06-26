import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../common/widgets/logout_view.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final SettingLogic logic = Get.find<SettingLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildSection(
                    title: '隐私设置',
                    children: [
                      Obx(() => _buildSelectRow(
                            label: '好友添加权限',
                            value: logic.friendPermission.label,
                            onTap: () => _showFriendPermissionPicker(context),
                          )),
                      _divider(),
                      Obx(() => _buildSwitchRow(
                            label: '陌生人私信',
                            value: logic.strangerChatEnabled,
                            onChanged: logic.toggleStrangerChat,
                          )),
                      _divider(),
                      Obx(() => _buildSwitchRow(
                            label: '黑名单',
                            value: logic.blacklistEnabled,
                            onChanged: logic.toggleBlacklist,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          LogoutView(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  // ---- 选择器弹窗 ----

  void _showFriendPermissionPicker(BuildContext context) {
    _showOptionSheet(
      context,
      title: '好友添加权限',
      current: logic.friendPermission,
      options: FriendPermission.values,
      onSelected: (v) => logic.setFriendPermission(v),
    );
  }

  void _showOptionSheet<T>(
    BuildContext context, {
    required String title,
    required T current,
    required List<T> options,
    required void Function(T) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题栏
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.c_8E9AB0,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.c_F0F2F6),
            // 选项列表
            ...options.map((opt) {
              final isSelected = opt.toString() == current.toString();
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onSelected(opt);
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          (opt as dynamic).label as String,
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected
                                ? AppColors.c_0089FF
                                : AppColors.c_0C1C33,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_rounded,
                          size: 22,
                          color: AppColors.c_0089FF,
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ---- UI components ----

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.c_8E9AB0,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFF,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSelectRow({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: AppTextStyles.ts_0C1C33_14sp),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 14, color: AppColors.c_8E9AB0),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.c_8E9AB0),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppTextStyles.ts_0C1C33_14sp),
          ),
          _AppSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.c_F0F2F6,
    );
  }
}

// ============================================================
// 自定义开关 — 胶囊状，与 APP 主体色适配
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
