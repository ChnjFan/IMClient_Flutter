import 'package:imclient_flutter/component/toast.dart';
import 'package:get/get.dart';
import '../../../../common/db/daos/friend_request_dao.dart';
import '../../../../common/utils/logger.dart';
import '../../../../core/controller/im_controller.dart';
import '../friend_applys_logic.dart';

class ProcessApplyLogic extends GetxController {
  final isProcessing = false.obs;

  late final FriendRequestWithProfile requestData;
  late final bool isOutgoing;

  final IMController _imLogic = Get.find<IMController>();
  final FriendApplysLogic _friendApplysLogic = Get.find<FriendApplysLogic>();

  @override
  void onInit() {
    super.onInit();
    requestData = Get.arguments as FriendRequestWithProfile;
    isOutgoing =
        requestData.request.uid == _imLogic.userInfo.value.uid;
  }

  /// 同意好友申请。
  Future<void> accept() async {
    if (isProcessing.value) return;
    isProcessing.value = true;
    try {
      final success = await _friendApplysLogic.accept(requestData);
      if (success) {
        Get.back();
      } else {
        AppToast.error('同意好友申请失败，请稍后重试');
      }
    } catch (e) {
      Logger.print('ProcessApply — accept error: $e');
      AppToast.error('同意好友申请失败，请稍后重试');
    } finally {
      isProcessing.value = false;
    }
  }

  /// 拒绝好友申请。
  Future<void> reject() async {
    if (isProcessing.value) return;
    isProcessing.value = true;
    try {
      final success = await _friendApplysLogic.reject(requestData);
      if (success) {
        Get.back();
      } else {
        AppToast.error('拒绝好友申请失败，请稍后重试');
      }
    } catch (e) {
      Logger.print('ProcessApply — reject error: $e');
      AppToast.error('拒绝好友申请失败，请稍后重试');
    } finally {
      isProcessing.value = false;
    }
  }
}
