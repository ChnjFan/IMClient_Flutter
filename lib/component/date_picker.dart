import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/styles/colors.dart';
import '../common/styles/text_styles.dart';

/// 底部弹出日期选择器（CupertinoDatePicker 滚轮风格）。
///
/// [title] 标题文案，[initialDate] 初始日期。
/// 选择后回调 [onSelected] 传入 yyyy-MM-dd 格式字符串。
class DatePicker {
  static void show({
    String title = '选择日期',
    String? initialDate,
    required void Function(String dateStr) onSelected,
  }) {
    DateTime selected = initialDate != null && initialDate.isNotEmpty
        ? DateTime.tryParse(initialDate) ?? DateTime(2000)
        : DateTime(2000);

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
              // 头部
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('取消'),
                    ),
                    Text(title, style: AppTextStyles.ts_0C1C33_14sp),
                    TextButton(
                      onPressed: () {
                        final dateStr =
                            '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
                        Get.back();
                        onSelected(dateStr);
                      },
                      child: const Text('确定',
                          style: TextStyle(color: AppColors.c_0089FF)),
                    ),
                  ],
                ),
              ),
              // 日期滚轮
              SizedBox(
                height: 220,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selected,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (v) => selected = v,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
