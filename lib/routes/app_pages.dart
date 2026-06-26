import 'package:get/get.dart';

import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_view.dart';
import '../pages/register/register_binding.dart';
import '../pages/register/register_view.dart';
import '../pages/reset_passwd/reset_passwd_binding.dart';
import '../pages/reset_passwd/reset_passwd_view.dart';
import '../pages/mine/about/about_binding.dart';
import '../pages/mine/about/about_view.dart';
import '../pages/mine/detail/avatar_edit/avatar_edit_binding.dart';
import '../pages/mine/detail/avatar_edit/avatar_edit_view.dart';
import '../pages/mine/detail/email_edit/email_edit_binding.dart';
import '../pages/mine/detail/email_edit/email_edit_view.dart';
import '../pages/mine/detail/name_edit/name_edit_binding.dart';
import '../pages/mine/detail/name_edit/name_edit_view.dart';
import '../pages/mine/detail/phone_edit/phone_edit_binding.dart';
import '../pages/mine/detail/phone_edit/phone_edit_view.dart';
import '../pages/mine/detail/signature_edit/signature_edit_binding.dart';
import '../pages/mine/detail/signature_edit/signature_edit_view.dart';
import '../pages/mine/detail/self_intro_edit/self_intro_edit_binding.dart';
import '../pages/mine/detail/self_intro_edit/self_intro_edit_view.dart';
import '../pages/mine/detail/user_detail_binding.dart';
import '../pages/mine/detail/user_detail_view.dart';
import '../pages/contacts/add_method/add_method_binding.dart';
import '../pages/contacts/add_method/add_method_view.dart';
import '../pages/contacts/add_method/search_friend/search_friend_binding.dart';
import '../pages/contacts/add_method/search_friend/search_friend_view.dart';
import '../pages/contacts/add_method/apply_friend/apply_friend_binding.dart';
import '../pages/contacts/add_method/apply_friend/apply_friend_view.dart';
import '../pages/contacts/friend_applys/friend_applys_binding.dart';
import '../pages/contacts/friend_applys/friend_applys_view.dart';
import '../pages/contacts/friend_applys/process_apply/process_apply_binding.dart';
import '../pages/contacts/friend_applys/process_apply/process_apply_view.dart';
import '../pages/contacts/user_profile_panel/user_profile_panel_binding.dart';
import '../pages/contacts/user_profile_panel/user_profile_panel_view.dart';
import '../pages/contacts/user_profile_panel/alias_edit/alias_edit_binding.dart';
import '../pages/contacts/user_profile_panel/alias_edit/alias_edit_view.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static GetPage _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
    bool popGesture = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: popGesture,
      );

  static final routes = <GetPage>[
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.forgetPassword,
      page: () => ResetPasswdPage(),
      binding: ResetPasswdBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userDetail,
      page: () => UserDetailPage(),
      binding: UserDetailBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.nameEdit,
      page: () => NameEditPage(),
      binding: NameEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.emailEdit,
      page: () => EmailEditPage(),
      binding: EmailEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.avatarEdit,
      page: () => AvatarEditPage(),
      binding: AvatarEditBinding(),
      popGesture: false,
    ),
    _pageBuilder(
      name: AppRoutes.phoneEdit,
      page: () => PhoneEditPage(),
      binding: PhoneEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.signatureEdit,
      page: () => SignatureEditPage(),
      binding: SignatureEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.selfIntroEdit,
      page: () => SelfIntroEditPage(),
      binding: SelfIntroEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.about,
      page: () => AboutPage(),
      binding: AboutBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.addMethod,
      page: () => AddMethodPage(),
      binding: AddMethodBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.searchFriend,
      page: () => SearchFriendPage(),
      binding: SearchFriendBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userProfilePanel,
      page: () => UserProfilePanelPage(),
      binding: UserProfilePanelBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.aliasEdit,
      page: () => AliasEditPage(),
      binding: AliasEditBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.applyFriend,
      page: () => ApplyFriendPage(),
      binding: ApplyFriendBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.friendApplys,
      page: () => FriendApplysPage(),
      binding: FriendApplysBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.processApply,
      page: () => const ProcessApplyPage(),
      binding: ProcessApplyBinding(),
    ),
  ];
}
