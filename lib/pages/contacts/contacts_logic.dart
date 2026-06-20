import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/friend_dao.dart';

class ContactsLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  late final FriendDao _friendDao;

  final friends = <FriendWithProfile>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<FriendWithProfile>>? _subscription;

  /// 按分组名称对好友进行分组。
  Map<String, List<FriendWithProfile>> get groupedFriends {
    final map = <String, List<FriendWithProfile>>{};
    for (final f in friends) {
      final group = f.friend.groupName;
      map.putIfAbsent(group, () => []).add(f);
    }
    return map;
  }

  @override
  void onInit() {
    super.onInit();
    _friendDao = _db.friendDao;
    _subscription = _friendDao.watchAllWithProfile().listen(
      (list) {
        friends.value = list;
        isLoading.value = false;
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
