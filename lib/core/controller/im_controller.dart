import 'dart:async';
import 'package:get/get.dart';
import 'package:imclient_flutter/common/db/database.dart';
import 'package:imclient_flutter/common/models/user/user_full_info.dart';
import 'package:imclient_flutter/routes/app_navigator.dart';
import 'package:imclient_flutter/common/models/login_certificate.dart';
import 'package:imclient_flutter/common/models/msg_id.dart';
import 'package:imclient_flutter/common/models/server_resp.dart';
import 'package:imclient_flutter/common/models/user/user_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/tcp_utils.dart';
import 'chat_tcp_client.dart';

enum IMSdkStatus {
  notInitialized,
  initializing,
  connecting,
  connectionSucceeded,
  connectionFailed,
  syncStart,
  syncProgress,
  syncEnded,
  syncFailed,
}

class IMSdkStatusInfo {
  final IMSdkStatus status;
  final int? progress;
  final bool reInstall;

  IMSdkStatusInfo({
    required this.status,
    this.progress,
    this.reInstall = false,
  });
}

/// IM SDK controller stub — manages SDK lifecycle, login/logout, and status streams.
/// In production this would wrap the real `flutter_openim_sdk`.
class IMController extends GetxController {
  // ---- Reactive status streams ----
  final initializedSubject = StreamController<bool>.broadcast();
  final imSdkStatusSubject = BehaviorSubject<IMSdkStatusInfo>.seeded(
    IMSdkStatusInfo(status: IMSdkStatus.notInitialized),
  );

  // ---- TCP 连接 ----
  final ChatTcpClient _tcp = ChatTcpClient();

  // ---- User info (reactive) ----
  /// 初始化为空 [UserInfo]，login() 成功后从 chatLoginRsp 更新其字段。
  final userInfo = UserInfo().obs;
  final userFullInfo = UserFullInfo().obs;

  /// 新的朋友申请未读计数，收到 notifyFriendApply 通知时自增。
  final newFriendApplyCount = 0.obs;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  void onInit() {
    super.onInit();
    Logger.print('IMController onInit — initializing SDK...');
    _bindTcpCallbacks();
    _registerHandlers();
    _initSDK();
  }

  /// Simulate SDK initialization.
  Future<void> _initSDK() async {
    imSdkStatus(IMSdkStatus.initializing);

    _isInitialized = true;
    imSdkStatus(IMSdkStatus.connectionSucceeded);
    if (!initializedSubject.isClosed) initializedSubject.add(true);

    Logger.print('IMController — SDK initialized');
  }

  /// 用户登录逻辑：建立 TCP 连接，发送 chatLoginReq，等待 chatLoginRsp 应答。
  /// 成功无返回值，失败抛异常并断开 TCP。
  Future<void> login(LoginCertificate cert) async {
    Logger.print('IMController — logging in uid: ${cert.userId} server: ${cert.chatServerIp}:${cert.chatServerPort}');
    imSdkStatus(IMSdkStatus.connecting);

    try {
      // 建立 TCP 长连接
      await _tcp.connect(cert);

      // 发送 chatLoginReq，等待 chatLoginRsp 应答
      final resp = await _tcp.sendRequest(
        MsgId.chatLoginReq,
        MsgId.chatLoginRsp,
        {'uid': cert.userId, 'token': cert.chatToken},
      );

      if (resp == null || !resp.isSuccess) {
        throw Exception('chat login failed');
      }
      // 从聊天服务器登录应答中提取用户资料
      userInfo.value = UserInfo.fromJson(resp.data);

      // 登录成功后拉取首次登录信息（包含 newFriendApplyCount 等）
      await _fetchFirstLoginInfo();
    } catch (e) {
      _tcp.disconnect();
      imSdkStatus(IMSdkStatus.connectionFailed);
      Logger.print('IMController — login failed: $e');
      rethrow;
    }

    imSdkStatus(IMSdkStatus.syncStart);
    imSdkStatus(IMSdkStatus.syncEnded);
    Logger.print('IMController — login success');
  }

  /// 登录成功后拉取首次登录信息，初始化 newFriendApplyCount 等状态。
  Future<void> _fetchFirstLoginInfo() async {
    try {
      final resp = await _tcp.sendRequest(
        MsgId.getFirstLoginInfoReq,
        MsgId.getFirstLoginInfoRsp,
        {'uid': userInfo.value.uid},
      );

      if (resp != null && resp.isSuccess) {
        final count = resp.get<int>('friend_apply_count') ?? 0;
        newFriendApplyCount.value = count;
        Logger.print('IMController — first login info fetched, newFriendApplyCount=$count');
      } else {
        Logger.print('IMController — getFirstLoginInfo failed: ${resp?.errCode}');
      }
    } catch (e) {
      Logger.print('IMController — getFirstLoginInfo error: $e');
    }
  }

  Future<bool> updateUserInfo({
    required String uid,
    String? name,
    String? email,
    String? avatarUrl,
    String? phone,
    int? gender,
    String? birthday,
    String? region,
    String? signature,
    String? selfIntro,
    int? privacyFriend,
    int? privacyChat,
    int? privacyBlacklist,
  }) async {
    // 仅发送 uid 和有值的字段
    final body = <String, dynamic>{'uid': uid};
    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (avatarUrl != null) body['avatar_url'] = avatarUrl;
    if (phone != null) body['phone'] = phone;
    if (gender != null) body['gender'] = gender;
    if (birthday != null) body['birthday'] = birthday;
    if (region != null) body['region'] = region;
    if (signature != null) body['signature'] = signature;
    if (selfIntro != null) body['self_intro'] = selfIntro;
    if (privacyFriend != null) body['privacy_friend'] = privacyFriend;
    if (privacyChat != null) body['privacy_chat'] = privacyChat;
    if (privacyBlacklist != null) body['blacklist_switch'] = privacyBlacklist;

    final resp = await _tcp.sendRequest(
      MsgId.updateUserInfoReq,
      MsgId.updateUserInfoRsp,
      body,
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — updateUserInfo failed: ${resp?.errCode}');
      return false;
    }

    final updated = userInfo.value;
    final updatedFull = userFullInfo.value;
    if (name != null) {
      updated.name = name;
      updatedFull.name = name;
    }
    if (email != null) {
      updated.email = email;
      updatedFull.email = email;
    }
    if (avatarUrl != null) {
      updated.avatarUrl = avatarUrl;
      updatedFull.avatarUrl = avatarUrl;
    }
    if (phone != null) updatedFull.phone = phone;
    if (gender != null) updatedFull.gender = gender;
    if (birthday != null) updatedFull.birthday = birthday;
    if (region != null) updatedFull.region = region;
    if (signature != null) updatedFull.signature = signature;
    if (selfIntro != null) updatedFull.selfIntro = selfIntro;
    if (privacyFriend != null) updatedFull.privacyFriend = privacyFriend;
    if (privacyChat != null) updatedFull.privacyChat = privacyChat;
    if (privacyBlacklist != null) updatedFull.privacyBlacklist = privacyBlacklist;
    userInfo.refresh();
    userFullInfo.refresh();
    return true;
  }

  Future<UserInfo> searchUserInfo({
    String? uid,
    String? email,
    String? nickname,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.searchUserReq,
      MsgId.searchUserRsp,
      {'uid': uid, 'email': email, 'name': nickname},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — searchUserInfo failed: ${resp?.errCode}');
      throw Exception('search user info failed');
    }

    return UserInfo.fromJson(resp.data);
  }

  /// 发送添加好友请求。
  /// [uid] 目标用户 ID，[reason] 申请留言。
  /// 返回 `true` 表示请求发送成功。
  Future<bool> addFriend({
    required String uid,
    required String reason,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.addFriendReq,
      MsgId.addFriendRsp,
      {'uid': userInfo.value.uid, 'friend_id': uid, 'message': reason},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — addFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
  }

  /// 拉取好友申请列表（支持增量拉取）。
  ///
  /// [sinceUpdateTime] 本地已存储的最大 updateTime 字符串，服务端只返回在此之后更新的记录。
  /// 传空字符串时拉取全量。
  Future<List<Map<String, dynamic>>> fetchFriendApplys({String sinceUpdateTime = ''}) async {
    final resp = await _tcp.sendRequest(
      MsgId.getFriendApplyReq,
      MsgId.getFriendApplyRsp,
      {'uid': userInfo.value.uid, 'since_update_time': sinceUpdateTime},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — fetchFriendApplys failed: ${resp?.errCode}');
      return [];
    }

    final list = resp.get<List<dynamic>>('data') ?? [];
    return list.cast<Map<String, dynamic>>();
  }

  /// 同意好友申请。
  /// [fromUid] 发起申请的用户 ID。
  /// 返回 `true` 表示操作成功。
  Future<bool> acceptFriend({required String fromUid}) async {
    final resp = await _tcp.sendRequest(
      MsgId.friendAuthReq,
      MsgId.friendAuthRsp,
      {'uid': userInfo.value.uid, 'friend_id': fromUid, 'result': 1},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — acceptFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
  }

  /// 拒绝好友申请。
  /// [fromUid] 发起申请的用户 ID。
  /// 返回 `true` 表示操作成功。
  Future<bool> rejectFriend({required String fromUid}) async {
    final resp = await _tcp.sendRequest(
      MsgId.friendAuthReq,
      MsgId.friendAuthRsp,
      {'uid': userInfo.value.uid, 'friend_id': fromUid, 'result': 0},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — rejectFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
  }

  /// 更新好友信息（备注等）。
  /// [friendId] 好友的用户 ID，[alias] 新备注名（传 null 表示不修改）。
  /// 返回 `true` 表示操作成功。
  Future<bool> updateFriend({
    required String friendId,
    String? alias,
  }) async {
    final body = <String, dynamic>{
      'uid': userInfo.value.uid,
      'friend_id': friendId,
    };
    if (alias != null) body['alias'] = alias;

    final resp = await _tcp.sendRequest(
      MsgId.updateFriendReq,
      MsgId.updateFriendRsp,
      body,
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — updateFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
  }

  /// 拉取好友列表（支持增量拉取）。
  ///
  /// [sinceUpdateTime] 本地已存储的最大 updateTime 字符串，服务端只返回在此之后更新的记录。
  /// 传空字符串时拉取全量。
  Future<List<Map<String, dynamic>>> fetchFriendList({String sinceUpdateTime = ''}) async {
    final resp = await _tcp.sendRequest(
      MsgId.getFriendListReq,
      MsgId.getFriendListRsp,
      {'uid': userInfo.value.uid, 'since_update_time': sinceUpdateTime},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — fetchFriendList failed: ${resp?.errCode}');
      return [];
    }

    final list = resp.get<List<dynamic>>('data') ?? [];
    return list.cast<Map<String, dynamic>>();
  }

  Future<UserFullInfo> getUserFullInfo({
    required String uid,
    required String from,
    }) async {
    if (uid.isEmpty || from.isEmpty) {
      Logger.print('IMController — getUserFullInfo input: $uid');
      return Future.error('get user full info failed');
    }

    final resp = await _tcp.sendRequest(
      MsgId.getUserFullInfoReq,
      MsgId.getUserFullInfoRsp,
      {'uid': uid, 'from': from},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — getUserFullInfo failed: ${resp?.errCode}');
      return Future.error('get user full info failed');
    }

    return UserFullInfo.fromJson(resp.data);
  }

  void _bindTcpCallbacks() {
    _tcp.onStatusChanged = (status) {
      Logger.print('TCP status: $status');
      if (status == TcpStatus.disconnected) {
        imSdkStatus(IMSdkStatus.connectionFailed);
      }
    };
  }

  void _registerHandlers() {
    _tcp.registerHandler(MsgId.chatLoginRsp, _onChatLoginRsp);
    _tcp.registerHandler(MsgId.notifyFriendApply, _onNotifyAddFriend);
    _tcp.registerHandler(MsgId.notifyFriendAuth, _onNotifyFriendAuth);
    _tcp.registerHandler(MsgId.notifyChatMsg, _onNotifyChatMsg);
    _tcp.registerHandler(MsgId.heartbeatRsp, _onHeartbeatRsp);
    _tcp.registerHandler(MsgId.offline, _onOffline);
  }

  void _onChatLoginRsp(ServerResp resp) {
    if (resp.isSuccess) {
      Logger.print('IMController — chat login success');
    } else {
      Logger.print('IMController — chat login failed: ${ServerError.getMsg(resp.errCode)}');
      imSdkStatus(IMSdkStatus.connectionFailed);
    }
  }

  void _onNotifyAddFriend(ServerResp resp) {
    Logger.print('IMController — friend request from: ${resp.get('friend_id')}');
    newFriendApplyCount.value++;
  }

  void _onNotifyFriendAuth(ServerResp resp) =>
      Logger.print('IMController — friend auth result from: ${resp.get('friend_id')}');

  void _onNotifyChatMsg(ServerResp resp) =>
      Logger.print('IMController — new message from: ${resp.get('fromUid')}');

  void _onHeartbeatRsp(ServerResp resp) =>
      Logger.print('IMController — heartbeat response received');
  
  void _onOffline(ServerResp resp) {
      Logger.print('IMController — offline notification received');
      logout();
      AppNavigator.startLogin();
  }

  /// 登出：断开 TCP、清除状态并清空本地数据库（调试用）。
  Future<void> logout() async {
    Logger.print('IMController — logging out');
    _tcp.disconnect();
    _isInitialized = false;
    imSdkStatus(IMSdkStatus.notInitialized);
    // 清空本地数据库所有数据
    try {
      final db = Get.find<AppDatabase>();
      await db.credentialDao.clear();
      await db.userProfileDao.clear();
      await db.friendDao.clear();
      await db.friendRequestDao.clear();
      await db.conversationDao.clear();
      await db.messageDao.clear();
      await db.settingsDao.clear();
      Logger.print('IMController — all database tables cleared');
    } catch (e) {
      Logger.print('IMController — failed to clear database: $e');
    }
  }

  void imSdkStatus(IMSdkStatus status, {int? progress, bool reInstall = false}) {
    imSdkStatusSubject.add(
      IMSdkStatusInfo(status: status, progress: progress, reInstall: reInstall),
    );
  }

  @override
  void onClose() {
    initializedSubject.close();
    imSdkStatusSubject.close();
    super.onClose();
  }
}

/// Explicitly typed BehaviorSubject (RxDart) for SDK status stream.
class BehaviorSubject<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  BehaviorSubject.seeded(T seedValue) {
    _value = seedValue;
  }

  T? _value;
  T? get value => _value;
  T? get values => _value;

  Stream<T> get stream => _controller.stream;

  void add(T event) {
    _value = event;
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void listen(void Function(T event) onData) {
    _controller.stream.listen(onData);
  }

  void close() {
    _controller.close();
  }
}
