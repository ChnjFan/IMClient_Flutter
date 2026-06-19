import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import 'about_logic.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  final AboutLogic logic = Get.find<AboutLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('关于'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // ---- 应用图标 & 名称 ----
            _buildHeader(),
            const SizedBox(height: 24),
            // ---- 信息列表 ----
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.c_0089FF_opacity10,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.chat_bubble_outline, size: 36, color: AppColors.c_0089FF),
        ),
        const SizedBox(height: 16),
        const Text(
          'IMClient',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.c_0C1C33),
        ),
        const SizedBox(height: 4),
        const Text(
          '即时通讯，随时随地',
          style: TextStyle(fontSize: 13, color: AppColors.c_8E9AB0),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final entries = logic.info.entries.toList();
        return Column(
          children: List.generate(entries.length, (i) {
            final isLast = i == entries.length - 1;
            return Column(
              children: [
                _buildInfoRow(entries[i].key, entries[i].value),
                if (!isLast) _divider(),
              ],
            );
          }),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: AppTextStyles.ts_0C1C33_14sp),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: AppColors.c_8E9AB0),
            ),
          ),
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
