import 'dart:async';
import 'package:get/get.dart';
import 'package:imclient_flutter/common/models/user/user_full_info.dart';
import 'package:imclient_flutter/routes/app_navigator.dart';
import 'package:imclient_flutter/common/models/login_certificate.dart';
import 'package:imclient_flutter/common/models/msg_id.dart';
import 'package:imclient_flutter/common/models/server_resp.dart';
import 'package:imclient_flutter/common/models/user/user_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/storage.dart';
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
    Logger.print('IMController — logging in userID: ${cert.userId} server: ${cert.chatServerIp}:${cert.chatServerPort}');
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
        {'uid': userInfo.value.userID},
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
    String? avatarUrl
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.updateUserInfoReq,
      MsgId.updateUserInfoRsp,
      {
        'uid': uid,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
      },
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — updateUserInfo failed: ${resp?.errCode}');
      return false;
    }

    final updated = userInfo.value;
    if (name != null) updated.name = name;
    if (email != null) updated.email = email;
    if (avatarUrl != null) updated.avatarUrl = avatarUrl;
    userInfo.refresh();
    return true;
  }

  Future<UserInfo> searchUserInfo({
    String? email,
    String? nickname,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.searchUserReq,
      MsgId.searchUserRsp,
      {'email': email, 'name': nickname},
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
      {'uid': userInfo.value.userID, 'friend_id': uid, 'msg': reason},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — addFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
  }

  /// 拉取好友申请列表（支持增量拉取）。
  ///
  /// [sinceId] 本地已存储的最大申请 id，服务端只返回 id > sinceId 的新记录。
  /// 传 0 或 null 时拉取全量。
  Future<List<Map<String, dynamic>>> fetchFriendApplys({int sinceId = 0}) async {
    final resp = await _tcp.sendRequest(
      MsgId.getFriendApplyReq,
      MsgId.getFriendApplyRsp,
      {'uid': userInfo.value.userID, 'since_id': sinceId},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — fetchFriendApplys failed: ${resp?.errCode}');
      return [];
    }

    final list = resp.get<List<dynamic>>('list') ?? [];
    return list.cast<Map<String, dynamic>>();
  }

  /// 同意好友申请。
  /// [fromUid] 发起申请的用户 ID。
  /// 返回 `true` 表示操作成功。
  Future<bool> acceptFriend({required String fromUid}) async {
    final resp = await _tcp.sendRequest(
      MsgId.friendAuthReq,
      MsgId.friendAuthRsp,
      {'uid': userInfo.value.userID, 'from_uid': fromUid, 'result': 1},
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
      {'uid': userInfo.value.userID, 'from_uid': fromUid, 'result': 0},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — rejectFriend failed: ${resp?.errCode}');
      return false;
    }
    return true;
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
    Logger.print('IMController — friend request from: ${resp.get('fromUid')}');
    newFriendApplyCount.value++;
  }

  void _onNotifyFriendAuth(ServerResp resp) =>
      Logger.print('IMController — friend auth result from: ${resp.get('fromUid')}');

  void _onNotifyChatMsg(ServerResp resp) =>
      Logger.print('IMController — new message from: ${resp.get('fromUid')}');

  void _onHeartbeatRsp(ServerResp resp) =>
      Logger.print('IMController — heartbeat response received');
  
  void _onOffline(ServerResp resp) {
      Logger.print('IMController — offline notification received');
      logout();
      AppNavigator.startLogin();
  }

  /// 登出：断开 TCP 并清除状态。
  Future<void> logout() async {
    Logger.print('IMController — logging out');
    _tcp.disconnect();
    _isInitialized = false;
    imSdkStatus(IMSdkStatus.notInitialized);
    await Storage.removeLoginCertificate();
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
