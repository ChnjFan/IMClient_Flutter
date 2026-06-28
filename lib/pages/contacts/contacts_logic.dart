import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/friend_dao.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';
import '../home/home_logic.dart';

class ContactsLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final IMController _imController = Get.find<IMController>();
  late final FriendDao _friendDao;

  final friends = <FriendWithProfile>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<FriendWithProfile>>? _subscription;
  bool _isFetching = false;

  /// 获取好友的展示名称：别名 > 昵称 > userId。
  ///
  /// 与 [UserInfo.getShowName] 保持一致：alias 或 name 为空字符串时视为无效，
  /// 继续向下 fallback，避免显示空白。
  String displayName(FriendWithProfile item) {
    final alias = item.friend.alias;
    final profileName = item.profile?.name;
    final userId = item.friend.userId;

    // 空字符串等同于 null，不展示
    if (alias != null && alias.isNotEmpty) return alias;
    if (profileName != null && profileName.isNotEmpty) return profileName;
    return userId;
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
        // 过滤掉自己的信息，以及已删除的好友（status=3）
        final currentUid = _imController.userInfo.value.uid;
        final filtered = list.where((f) => f.friend.userId != currentUid && f.friend.status != 3).toList();
        friends.value = filtered;
        isLoading.value = false;
        if (filtered.isNotEmpty) {
          final first = filtered.first;
          Logger.print(
              'ContactsLogic — watch emitted ${filtered.length} friends (filtered from ${list.length}). '
              'First: alias=${first.friend.alias}, profileName=${first.profile?.name}, '
              'userId=${first.friend.userId}, profileIsNull=${first.profile == null}');
        }
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
    _fetchFriendListFromServer();

    // 每次切换到通讯录 tab 时向服务端拉取最新好友列表
    final homeLogic = Get.find<HomeLogic>();
    ever<int>(homeLogic.index, (idx) {
      if (idx == 1) _fetchFriendListFromServer();
    });
  }

  /// 从服务端增量拉取好友列表。
  Future<void> _fetchFriendListFromServer() async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      final sinceUpdateTime = await _friendDao.getMaxUpdateTime();
      Logger.print('ContactsLogic — fetching friend list with sinceUpdateTime=$sinceUpdateTime');
      final list = await _imController.fetchFriendList(sinceUpdateTime: sinceUpdateTime);
      Logger.print('ContactsLogic — server returned ${list.length} friends');
      if (list.isNotEmpty) {
        await _friendDao.syncFromServer(list, sinceUpdateTime: sinceUpdateTime);
        Logger.print('ContactsLogic — synced ${list.length} friends from server (sinceUpdateTime=$sinceUpdateTime)');
      }
    } catch (e, stack) {
      Logger.print('ContactsLogic — fetchFriendList error: $e\n$stack');
      isLoading.value = false;
    } finally {
      _isFetching = false;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
