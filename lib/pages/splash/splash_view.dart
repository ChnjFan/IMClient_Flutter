import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/styles/colors.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  // Get.find is safe here because SplashBinding lazy-puts SplashLogic
  final SplashLogic logic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FFFFFF,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppImages.loginBackground,
              width: 280,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            const Text(
              '即时通讯，随时随地',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.c_8E9AB0,
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.c_0089FF,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
