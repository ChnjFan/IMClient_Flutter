part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String forgetPassword = '/forget_password';
  static const String userDetail = '/user_detail';
  static const String nameEdit = '/user_detail/name_edit';
  static const String emailEdit = '/user_detail/email_edit';
  static const String avatarEdit = '/user_detail/avatar_edit';
  static const String phoneEdit = '/user_detail/phone_edit';
  static const String signatureEdit = '/user_detail/signature_edit';
  static const String selfIntroEdit = '/user_detail/self_intro_edit';
  static const String about = '/about';
  static const String addMethod = '/contacts/add_method';
  static const String searchFriend = '/contacts/search_friend';
  static const String userProfilePanel = '/contacts/user_profile_panel';
  static const String aliasEdit = '/contacts/alias_edit';
  static const String applyFriend = '/contacts/apply_friend';
  static const String friendApplys = '/contacts/friend_applys';
  static const String processApply = '/contacts/process_apply';
}
