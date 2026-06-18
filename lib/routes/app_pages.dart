import 'package:get/get.dart';

import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_view.dart';
import '../pages/register/register_binding.dart';
import '../pages/register/register_view.dart';
import '../pages/reset_passwd/reset_passwd_binding.dart';
import '../pages/reset_passwd/reset_passwd_view.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_view.dart';
import '../pages/user_detail/user_detail_binding.dart';
import '../pages/user_detail/user_detail_view.dart';

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
  ];
}
