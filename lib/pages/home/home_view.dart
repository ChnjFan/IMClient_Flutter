import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../contacts/contacts_view.dart';
import '../mine/mine_view.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeLogic logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(
        () => IndexedStack(
          index: logic.index.value,
          children: [
            _buildPlaceholderTab(AppStrings.home, AppImages.homeTabSel),
            ContactsPage(),
            MinePage(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: logic.index.value,
          onTap: logic.switchTab,
          selectedItemColor: AppColors.c_0089FF,
          unselectedItemColor: AppColors.c_8E9AB0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(AppImages.homeTabNor),
              activeIcon: Icon(AppImages.homeTabSel),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppImages.contactsTabNor),
              activeIcon: Icon(AppImages.contactsTabSel),
              label: AppStrings.contacts,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppImages.mineTabNor),
              activeIcon: Icon(AppImages.mineTabSel),
              label: AppStrings.mine,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: AppColors.c_0089FF_opacity10),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.c_8E9AB0,
            ),
          ),
        ],
      ),
    );
  }
}
