# 路由系统与导航

## 路由定义

### 路由名称常量 ([app_routes.dart](../lib/routes/app_routes.dart))

使用 `part of 'app_pages.dart'` 机制，路由常量与路由表定义在同一个库中：

```dart
part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';          // 预留
  static const String forgetPassword = '/forget_password'; // 预留
}
```

### 路由表 ([app_pages.dart](../lib/routes/app_pages.dart))

将路由名称映射到页面组件和绑定的 `GetPage` 列表：

```dart
class AppPages {
  AppPages._();

  static GetPage _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
    bool popGesture = true,
  }) => GetPage(
    name: name,
    page: page,
    binding: binding,
    preventDuplicates: preventDuplicates,
    transition: Transition.cupertino,     // iOS 风格动画
    popGesture: popGesture,
  );

  static final routes = <GetPage>[
    _pageBuilder(name: AppRoutes.splash, page: () => SplashPage(), binding: SplashBinding()),
    _pageBuilder(name: AppRoutes.login,  page: () => LoginPage(),  binding: LoginBinding()),
    _pageBuilder(name: AppRoutes.home,   page: () => HomePage(),   binding: HomeBinding()),
  ];
}
```

**路由参数说明**：

| 参数 | 说明 |
|------|------|
| `name` | 路由路径，如 `/login` |
| `page` | 返回页面 Widget 的函数 |
| `binding` | 进入路由时自动注册的依赖注入 |
| `preventDuplicates` | 是否阻止重复推入相同页面 |
| `transition` | 页面切换动画类型（本项目统一使用 `Transition.cupertino`） |
| `popGesture` | 是否启用 iOS 侧滑返回手势 |

## 集中式导航 ([app_navigator.dart](../lib/routes/app_navigator.dart))

所有页面跳转通过 `AppNavigator` 的静态方法完成，禁止在页面中直接调用 `Get.to` 等 API：

```dart
class AppNavigator {
  AppNavigator._();

  // 跳转到登录页（清除整个导航栈）
  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  // 跳转到主页（清除整个导航栈，携带参数）
  static void startMain({bool isAutoLogin = false}) {
    Get.offAllNamed(AppRoutes.home, arguments: {'isAutoLogin': isAutoLogin});
  }

  // 从 Splash 跳转到主页（替换当前页，适用于启动后）
  static void startSplashToMain({bool isAutoLogin = false}) {
    Get.offAndToNamed(AppRoutes.home, arguments: {'isAutoLogin': isAutoLogin});
  }

  // 回到主页
  static void startBackMain() {
    Get.until((route) => Get.currentRoute == AppRoutes.home);
  }

  // 跳转到注册页 (预留)
  static void startRegister() {
    Get.toNamed(AppRoutes.register);
  }

  // 跳转到忘记密码页 (预留)
  static void startForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }
}
```

## 导航方法对比

| 方法 | 栈行为 | 使用场景 |
|------|--------|----------|
| `Get.offAllNamed()` | 清空整个栈 + 推入新页 | Splash → Login / Login → Home |
| `Get.offAndToNamed()` | 替换当前页 + 推入新页 | Splash → Home (自动登录) |
| `Get.toNamed()` | 正常推入 | Login → Register / Login → ForgetPwd |
| `Get.until()` | 连续弹出直到条件满足 | 从深层页面回到 Home |

## 页面间参数传递

### 传递参数

```dart
Get.offAllNamed(
  AppRoutes.home,
  arguments: {'isAutoLogin': true, 'conversations': result},
);
```

### 接收参数

```dart
// 在 home_logic.dart 的 onInit() 中
_isAutoLogin = Get.arguments != null ? Get.arguments['isAutoLogin'] : false;
```

## 导航流程

```
┌──────────┐    无凭据     ┌──────────┐
│  Splash  │ ───────────► │  Login   │
│  (加载)  │              │ (登录)   │
│          │  有凭据+成功  │          │
│          │ ──────────►  │          │
│          │              │  登录成功  │
│          │              │ ───────►  │
└──────────┘              └──────┬───┘
                                 │
                          ┌──────▼───┐
                          │   Home   │
                          │  (主页)  │
                          └──────────┘
```

**Splash → Login**：清栈跳转（用户不应回到 Splash）
**Splash → Home**：替换跳转（自动登录成功，同不应回到 Splash）
**Login → Home**：清栈跳转（登录成功后不应回到 Login）

## 预留路由

`/register` 和 `/forget_password` 已在 `AppRoutes` 中定义，`AppNavigator` 中有对应的导航方法，登录页中的"立即注册"和"忘记密码"按钮已连接到这些方法，但尚未创建对应的页面和路由表条目。后续开发时只需：

1. 创建 `pages/register/` 和 `pages/forget_password/` 页面三件套
2. 在 `app_pages.dart` 的路由表中添加对应的 `GetPage` 条目
