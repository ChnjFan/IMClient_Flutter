import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/styles/colors.dart';
import '../common/styles/text_styles.dart';

/// 底部弹出性别选择器。
///
/// [selected] 当前选中的性别值（0=未知, 1=男, 2=女）。
/// 选择后回调 [onSelected]，不关闭则传 null。
class GenderPicker {
  static void show({
    int? selected,
    required void Function(int value) onSelected,
  }) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Text('选择性别', style: AppTextStyles.ts_0C1C33_14sp),
              ),
              _buildItem('男', 1, selected, onSelected),
              _buildItem('女', 2, selected, onSelected),
              _buildItem('未设置', 0, selected, onSelected),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildItem(
    String label,
    int value,
    int? selected,
    void Function(int) onSelected,
  ) {
    return ListTile(
      title: Text(label),
      trailing: selected == value
          ? const Icon(Icons.check, color: AppColors.c_0089FF)
          : null,
      onTap: () {
        Get.back();
        onSelected(value);
      },
    );
  }
}
