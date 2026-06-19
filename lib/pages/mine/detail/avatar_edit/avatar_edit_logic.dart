import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/controller/im_controller.dart';

class AvatarEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  final ImagePicker _picker = ImagePicker();

  String get avatarUrl => imLogic.userInfo.value.avatarUrl ?? '';

  /// 拍照 → 裁剪 → 保存
  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (photo != null) {
      final cropped = await _cropImage(photo.path);
      if (cropped != null) {
        _updateAvatar(cropped);
      }
    }
  }

  /// 相册选择 → 裁剪 → 保存
  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (image != null) {
      final cropped = await _cropImage(image.path);
      if (cropped != null) {
        _updateAvatar(cropped);
      }
    }
  }

  /// 裁剪图片
  Future<String?> _cropImage(String path) async {
    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '编辑头像',
          toolbarColor: const Color(0xFF0C1C33),
          toolbarWidgetColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFF000000),
          cropFrameColor: const Color(0xFF0089FF),
          hideBottomControls: false,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          showCancelConfirmationDialog: false,
        ),
      ],
    );
    return cropped?.path;
  }

  /// 保存图片到相册
  Future<void> saveToGallery() async {
    final url = avatarUrl;
    if (url.isEmpty) {
      Get.snackbar('', '暂无头像可保存', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      if (url.startsWith('http')) {
        final dir = await getTemporaryDirectory();
        final filePath = '${dir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await Dio().download(url, filePath);
        await ImageGallerySaver.saveFile(filePath);
      } else {
        await ImageGallerySaver.saveFile(url);
      }
      Get.snackbar('', '已保存到相册', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('', '保存失败', snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// 更新头像
  Future<void> _updateAvatar(String path) async {
    final uid = imLogic.userInfo.value.userID ?? '';
    final success = await imLogic.updateUserInfo(uid: uid, avatarUrl: path);
    if (!success) {
      Get.snackbar('', '更新头像失败', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.back(result: path);
  }
}
