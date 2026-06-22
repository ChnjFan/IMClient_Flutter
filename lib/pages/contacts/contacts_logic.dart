import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/friend_dao.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';

class ContactsLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final IMController _imController = Get.find<IMController>();
  late final FriendDao _friendDao;

  final friends = <FriendWithProfile>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<FriendWithProfile>>? _subscription;

  /// 获取好友的展示名称：别名 > 昵称 > userId。
  String displayName(FriendWithProfile item) {
    return item.friend.alias ??
        item.profile?.name ??
        item.friend.userId;
  }

  /// 按名称首字母对好友进行分组（A-Z + #），组内按名称字母序排列。
  Map<String, List<FriendWithProfile>> get sortedGroupedFriends {
    final map = <String, List<FriendWithProfile>>{};
    for (final f in friends) {
      final letter = _getSectionKey(displayName(f));
      map.putIfAbsent(letter, () => []).add(f);
    }
    // 组内按名称排序
    for (final list in map.values) {
      list.sort((a, b) => displayName(a).compareTo(displayName(b)));
    }
    return map;
  }

  /// 排序后的分组键列表（A-Z + #），用于索引栏。
  List<String> get sortedGroupKeys {
    final keys = sortedGroupedFriends.keys.toList();
    // A-Z 在前，# 在最后
    keys.sort((a, b) {
      if (a == '#') return 1;
      if (b == '#') return -1;
      return a.compareTo(b);
    });
    return keys;
  }

  /// 全量索引字母表（A-Z + #），用于右侧快速索引栏。
  static const List<String> indexLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#',
  ];

  /// 根据名称首字符返回分组键：大写字母返回该字母，否则返回 '#'。
  String _getSectionKey(String name) {
    if (name.isEmpty) return '#';
    final first = name[0].toUpperCase();
    if (first.codeUnitAt(0) >= 65 && first.codeUnitAt(0) <= 90) {
      return first;
    }
    return '#';
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
    _fetchFriendListFromServer();
  }

  /// 进入通讯录后，从服务端增量拉取好友列表。
  Future<void> _fetchFriendListFromServer() async {
    try {
      final sinceId = await _friendDao.getMaxId();
      Logger.print('ContactsLogic — fetching friend list with sinceId=$sinceId');
      final list = await _imController.fetchFriendList(sinceId: sinceId);
      Logger.print('ContactsLogic — server returned ${list.length} friends');
      if (list.isNotEmpty) {
        await _friendDao.syncFromServer(list, sinceId: sinceId);
        Logger.print('ContactsLogic — synced ${list.length} friends from server (sinceId=$sinceId)');
      }
    } catch (e, stack) {
      Logger.print('ContactsLogic — fetchFriendList error: $e\n$stack');
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
