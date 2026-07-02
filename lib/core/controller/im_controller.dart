import 'dart:async';
import 'dart:io' as dart_io;
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
  Future<int> addFriend({
    required String uid,
    required String reason,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.addFriendReq,
      MsgId.addFriendRsp,
      {'uid': userInfo.value.uid, 'friend_id': uid, 'message': reason},
    );

    if (resp == null) {
      Logger.print('IMController — addFriend failed: no response');
      return ServerError.errRequest;
    }

    // errIsFriend 表示双方已是好友，按成功处理
    if (resp.isSuccess || resp.errCode == ServerError.errIsFriend) {
      return resp.errCode;
    }

    Logger.print('IMController — addFriend failed: ${resp.errCode}');
    return resp.errCode;
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

  /// 更新好友信息（备注、状态、星标、屏蔽、隐藏等）。
  /// [friendId] 好友的用户 ID。仅发送非 null 字段。
  /// 返回 `true` 表示操作成功。
  Future<bool> updateFriend({
    required String friendId,
    String? alias,
    int? status,
    int? isStarred,
    int? isHidden,
  }) async {
    final body = <String, dynamic>{
      'uid': userInfo.value.uid,
      'friend_id': friendId,
    };
    if (alias != null) body['alias'] = alias;
    if (status != null) body['status'] = status;
    if (isStarred != null) body['is_star'] = isStarred;
    if (isHidden != null) body['is_hide'] = isHidden;

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

  /// 删除好友。
  /// [friendId] 好友的用户 ID。返回 `true` 表示操作成功。
  Future<bool> deleteFriend({required String friendId}) async {
    final resp = await _tcp.sendRequest(
      MsgId.deleteFriendReq,
      MsgId.deleteFriendRsp,
      {'uid': userInfo.value.uid, 'friend_id': friendId},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — deleteFriend failed: ${resp?.errCode}');
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

  /// 拉取会话列表，返回原始服务端数据。
  ///
  /// [sinceUpdateTime] 不为 0 时为增量拉取，服务端仅返回 update_time > 该值的会话。
  Future<List<Map<String, dynamic>>> fetchConversationList({int sinceUpdateTime = 0}) async {
    final req = <String, dynamic>{'uid': userInfo.value.uid};
    if (sinceUpdateTime > 0) {
      req['since_update_time'] = sinceUpdateTime;
    }
    final resp = await _tcp.sendRequest(
      MsgId.getConversationListReq,
      MsgId.getConversationListRsp,
      req,
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — fetchConversationList failed: ${resp?.errCode}');
      return [];
    }

    final list = resp.get<List<dynamic>>('data') ?? [];
    return list.cast<Map<String, dynamic>>();
  }

  /// 创建单聊会话，返回 convId。成功后将服务端返回的会话信息写入本地数据库。
  ///
  /// [title] 会话标题（单聊时为对方显示名）。
  Future<String?> createConversation({required String toUid, String? title}) async {
    final resp = await _tcp.sendRequest(
      MsgId.chatConvCreateReq,
      MsgId.chatConvCreateRsp,
      {'uid': userInfo.value.uid, 'friend_id': toUid},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — createConversation failed: ${resp?.errCode}');
      return null;
    }

    final convId = resp.get<String>('conv_id');
    Logger.print('IMController — conversation created: $convId');

    // 仅当本地不存在该会话时才写入，避免覆盖本地已更新的最后消息
    try {
      final db = Get.find<AppDatabase>();
      final existing = await db.conversationDao.getById(convId ?? '');
      if (existing == null) {
        await db.conversationDao.upsertFromCreateResponse(resp.data, titleOverride: title);
        Logger.print('IMController — conversation saved to local db: $convId');
      } else {
        Logger.print('IMController — conversation already exists locally, skipping upsert: $convId');
      }
    } catch (e) {
      Logger.print('IMController — failed to save conversation to local db: $e');
    }

    return convId;
  }

  /// 发送聊天消息，返回服务端消息 ID（成功时）或 null（失败时）。
  Future<int?> sendMessage({
    required String convId,
    required String toUid,
    required String content,
    int contentType = 0,
    int msgId = 0,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.chatMsgReq,
      MsgId.chatMsgRsp,
      {
        'from_uid': userInfo.value.uid,
        'to_uid': toUid,
        'conv_id': convId,
        'content': content,
        'content_type': contentType,
        'msg_id': msgId,
      },
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — sendMessage failed: ${resp?.errCode}');
      return null;
    }

    final rawMsgId = resp.get<String>('msg_id');
    return rawMsgId != null ? int.tryParse(rawMsgId) : msgId;
  }

  /// 拉取会话历史消息。
  ///
  /// 返回 `(list, hasMore)` —— [list] 为消息原始数据列表，[hasMore] 为 1 表示服务端仍有更多历史数据待拉取。
  Future<({List<Map<String, dynamic>> list, int hasMore})> fetchHistoryMessages({
    required String convId,
    int limit = 20,
    int msgId = 0,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.chatConvHistoryMsgReq,
      MsgId.chatConvHistoryMsgRsp,
      {
        'conv_id': convId,
        'limit': limit,
        'since_msg_id': msgId,
      },
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — fetchHistoryMessages failed: ${resp?.errCode}');
      return (list: <Map<String, dynamic>>[], hasMore: 0);
    }

    final list = (resp.get<List<dynamic>>('data') ?? []).cast<Map<String, dynamic>>();
    final hasMore = resp.get<int>('has_more') ?? 0;
    return (list: list, hasMore: hasMore);
  }

  /// 回复服务端已接收历史消息。
  ///
  /// [count] 接收到的消息个数，[lastMsgId] 接收到的最大服务端消息 ID。
  void updateMessagesStatus({
    required String convId,
    required int count,
    required int lastMsgId,
    required int status,
  }) {
    _tcp.sendNotify(
      MsgId.updateConvMessageStatusReq,
      {
        'uid': userInfo.value.uid,
        'conv_id': convId,
        'count': count,
        'last_msg_id': lastMsgId,
        'status': status,
      },
    );
    Logger.print('IMController — update messages status: conv=$convId count=$count lastMsgId=$lastMsgId status=$status');
  }

  /// 上传文件，返回文件 URL。
  Future<String?> uploadFile(String filePath) async {
    // 读取文件字节并转为 base64 发送（未来可改为分块上传）
    try {
      final file = await _readFileBytes(filePath);
      if (file == null) return null;

      final resp = await _tcp.sendRequest(
        MsgId.uploadFileReq,
        MsgId.uploadFileRsp,
        {
          'uid': userInfo.value.uid,
          'file_name': filePath.split('/').last,
          'file_data': file,
        },
      );

      if (resp == null || !resp.isSuccess) {
        Logger.print('IMController — uploadFile failed: ${resp?.errCode}');
        return null;
      }

      return resp.get<String>('url');
    } catch (e) {
      Logger.print('IMController — uploadFile error: $e');
      return null;
    }
  }

  /// 读取文件并返回 base64 编码字符串。
  Future<String?> _readFileBytes(String filePath) async {
    try {
      final bytes = await dart_io.File(filePath).readAsBytes();
      return _base64Encode(bytes);
    } catch (e) {
      Logger.print('IMController — _readFileBytes error: $e');
      return null;
    }
  }

  static String _base64Encode(List<int> bytes) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    final result = StringBuffer();
    int i = 0;
    while (i < bytes.length) {
      final b0 = bytes[i];
      final b1 = i + 1 < bytes.length ? bytes[i + 1] : 0;
      final b2 = i + 2 < bytes.length ? bytes[i + 2] : 0;
      result.write(chars[(b0 >> 2) & 63]);
      result.write(chars[((b0 << 4) | (b1 >> 4)) & 63]);
      result.write(i + 1 < bytes.length ? chars[((b1 << 2) | (b2 >> 6)) & 63] : '=');
      result.write(i + 2 < bytes.length ? chars[b2 & 63] : '=');
      i += 3;
    }
    return result.toString();
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

  void _onNotifyChatMsg(ServerResp resp) async {
    Logger.print('IMController — new message from: ${resp.get('fromUid')}');
    try {
      final convId = resp.get<String>('conv_id') ?? '';
      final fromUid = resp.get<String>('from_uid') ?? '';
      final toUid = resp.get<String>('to_uid') ?? '';
      final content = resp.get<String>('content') ?? '';
      final contentType = resp.get<int>('content_type') ?? 0;
      final rawMsgId = resp.get<String>('msg_id');
      final serverMsgId = rawMsgId != null ? int.tryParse(rawMsgId) : null;
      final createTime = resp.get<int>('create_time') ?? DateTime.now().millisecondsSinceEpoch;

      if (convId.isNotEmpty) {
        final db = Get.find<AppDatabase>();

        // 插入消息到本地数据库
        final id = await db.messageDao.insertFromNotification(
          conversationId: convId,
          fromUid: fromUid,
          toUid: toUid,
          content: content,
          contentType: contentType,
          createTime: createTime,
        );
        if (serverMsgId != null) {
          await db.messageDao.updateServerMsgId(id, serverMsgId);
        }

        // 更新会话列表
        await db.conversationDao.upsertFromNewMessage(
          convId: convId,
          fromUid: fromUid,
          content: content,
        );
      }
    } catch (e) {
      Logger.print('IMController — _onNotifyChatMsg update conversation error: $e');
    }
  }

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
