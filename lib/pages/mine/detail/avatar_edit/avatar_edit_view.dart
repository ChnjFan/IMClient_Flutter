import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import 'avatar_edit_logic.dart';

class AvatarEditPage extends StatelessWidget {
  AvatarEditPage({super.key});

  final AvatarEditLogic logic = Get.find<AvatarEditLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Center(
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            color: Colors.white,
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              switch (value) {
                case 'camera':
                  logic.takePhoto();
                  break;
                case 'gallery':
                  logic.pickFromGallery();
                  break;
                case 'save':
                  logic.saveToGallery();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'camera',
                child: _MenuItem(icon: Icons.camera_alt_outlined, text: '拍照'),
              ),
              const PopupMenuItem(
                value: 'gallery',
                child: _MenuItem(icon: Icons.photo_outlined, text: '相册选择'),
              ),
              const PopupMenuItem(
                value: 'save',
                child: _MenuItem(icon: Icons.download_outlined, text: '保存图片'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'cancel',
                child: _MenuItem(icon: null, text: '取消', center: true),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Obx(() {
            final url = logic.avatarUrl;
            if (url.isEmpty) {
              return const Icon(Icons.person, size: 120, color: AppColors.c_8E9AB0);
            }
            if (url.startsWith('http')) {
              return Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (_, e, s) =>
                    const Icon(Icons.person, size: 120, color: AppColors.c_8E9AB0),
              );
            }
            return Image.file(
              File(url),
              fit: BoxFit.contain,
              errorBuilder: (_, e, s) =>
                  const Icon(Icons.person, size: 120, color: AppColors.c_8E9AB0),
            );
          }),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({this.icon, required this.text, this.center = false});
  final IconData? icon;
  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: AppColors.c_333333),
            const SizedBox(width: 12),
          ],
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: AppColors.c_333333),
          ),
        ],
      ),
    );
  }
}
