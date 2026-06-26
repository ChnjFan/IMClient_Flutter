class MsgId {
  // ---- 登录注册消息 ----
  static const int getVerifyCode = 1001;
  static const int userRegister = 1002;
  static const int resetPasswd = 1003;
  static const int userLogin = 1004;

  // ---- 聊天服务消息 ----
  static const int chatLoginReq = 1005;
  static const int chatLoginRsp = 1006;

  // ---- 登录后信息获取 ----
  static const int getFirstLoginInfoReq = 1101;
  static const int getFirstLoginInfoRsp = 1102;

  // ---- 好友搜索添加消息 ----
  static const int searchUserReq = 2001;
  static const int searchUserRsp = 2002;
  static const int addFriendReq = 2003;
  static const int addFriendRsp = 2004;
  static const int notifyFriendApply = 2005;
  static const int friendAuthReq = 2006;
  static const int friendAuthRsp = 2007;
  static const int notifyFriendAuth = 2008;
  static const int getFriendApplyReq = 2009;
  static const int getFriendApplyRsp = 2010;
  static const int getFriendListReq = 2011;
  static const int getFriendListRsp = 2012;
  static const int updateFriendReq = 2013;
  static const int updateFriendRsp = 2014;

  // ---- 用户资料消息 ----
  static const int updateUserInfoReq = 2101;
  static const int updateUserInfoRsp = 2102;
  static const int getUserFullInfoReq = 2103;
  static const int getUserFullInfoRsp = 2104;

  // ---- 聊天消息 ----
  static const int chatMsgReq = 3001;
  static const int chatMsgRsp = 3002;
  static const int notifyChatMsg = 3003;
  static const int uploadFileReq = 3004;
  static const int uploadFileRsp = 3005;
  static const int downloadFileReq = 3006;
  static const int downloadFileRsp = 3007;

  // ---- 会话相关消息 ----
  static const int chatConvCreateReq = 4001;
  static const int chatConvCreateRsp = 4002;
  static const int chatConvHistoryMsgReq = 4003;
  static const int chatConvHistoryMsgRsp = 4004;

  // ---- 系统消息 ----
  static const int offline = 5001;
  static const int heartbeatReq = 5002;
  static const int heartbeatRsp = 5003;
  static const int commonRsp = 5004;
}