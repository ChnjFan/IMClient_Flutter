import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/styles/colors.dart';
import '../common/styles/text_styles.dart';

/// 底部弹出地区选择器。
///
/// [title] 标题文案，[selected] 当前选中的地区名。
/// 选择后回调 [onSelected] 传入地区名称。
class RegionPicker {
  static const regions = [
    '北京', '上海', '广东', '浙江', '江苏', '四川', '湖北', '湖南',
    '福建', '山东', '河南', '河北', '辽宁', '陕西', '重庆', '天津',
    '安徽', '江西', '广西', '云南', '贵州', '山西', '吉林', '黑龙江',
    '内蒙古', '甘肃', '海南', '新疆', '宁夏', '青海', '西藏',
    '香港', '澳门', '台湾', '海外',
  ];

  static void show({
    String title = '选择地区',
    String? selected,
    required void Function(String region) onSelected,
  }) {
    final current = selected ?? '';

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.5),
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('取消'),
                    ),
                    Text(title, style: AppTextStyles.ts_0C1C33_14sp),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.c_F0F2F6),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: regions.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(regions[i]),
                    trailing: regions[i] == current
                        ? const Icon(Icons.check, color: AppColors.c_0089FF)
                        : null,
                    onTap: () {
                      Get.back();
                      onSelected(regions[i]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
