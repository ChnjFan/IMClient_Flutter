# GetX 框架使用模式

本文档描述 GetX 框架在本项目中的具体使用方式和最佳实践。

## 1. 应用初始化 — GetMaterialApp

在 [app.dart](../lib/app.dart) 中，使用 `GetMaterialApp` 替代 Flutter 原生的 `MaterialApp`：

```dart
GetMaterialApp(
  debugShowCheckedModeBanner: false,
  enableLog: true,
  translations: _AppTranslations(),       // 国际化
  localizationsDelegates: [...],
  fallbackLocale: const Locale('zh', 'CN'),
  supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
  getPages: AppPages.routes,              // 路由表
  initialBinding: InitBinding(),          // 全局依赖注入
  initialRoute: AppRoutes.splash,         // 起始路由
  theme: _buildTheme(),
)
```

**关键点**：
- `getPages` 接收 `GetPage` 列表，定义所有页面路由
- `initialBinding` 在应用启动时注入全局控制器
- `initialRoute` 指定起始页面

## 2. 依赖注入 — Bindings

### 全局绑定 (InitBinding)

在 [app.dart](../lib/app.dart#L113-L117) 中注册应用级控制器：

```dart
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMController>(() => IMController(), fenix: true);
  }
}
```

**`fenix: true`**：即使控制器被移除，再次 `Get.find` 时会重新创建。适用于整个应用生命周期需要的控制器。

### 页面级绑定

每个页面有自己的 Binding，使用 `Get.lazyPut` 惰性创建：

```dart
// splash_binding.dart
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashLogic());
  }
}
```

### 在路由中关联绑定

在 [app_pages.dart](../lib/routes/app_pages.dart) 中：

```dart
GetPage(
  name: AppRoutes.splash,
  page: () => SplashPage(),
  binding: SplashBinding(),  // 进入此路由时自动注册
  transition: Transition.cupertino,
)
```

## 3. 控制器 — GetxController

### 基本结构

```dart
class SplashLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>(); // 获取全局控制器

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑：订阅流、加载数据等
  }

  @override
  void onClose() {
    // 清理资源：取消订阅、释放控制器等
    super.onClose();
  }
}
```

### 生命周期钩子

| 钩子 | 触发时机 |
|------|----------|
| `onInit()` | 控制器被创建时（最先执行） |
| `onReady()` | 首次 `build` 完成后（适合获取包信息等） |
| `onClose()` | 控制器被销毁时（清理资源） |

在本项目中，`LoginLogic` 使用了 `GetTickerProviderStateMixin` 来支持 `TabController`：

```dart
class LoginLogic extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }
}
```

## 4. 响应式状态 — .obs + Obx

### 声明响应式变量

使用 `.obs` 将普通变量变为响应式：

```dart
// login_logic.dart
final enabled = false.obs;          // RxBool
final areaCode = '+86'.obs;         // RxString
final loginType = LoginType.phone.obs; // Rx<LoginType>
final versionInfo = ''.obs;         // RxString
```

### 在 View 中订阅

使用 `Obx()` 包裹需要自动更新的 Widget：

```dart
// login_view.dart
Obx(() => PrimaryButton(
  text: AppStrings.login,
  enabled: logic.enabled.value,   // 当 logic.enabled 变化时自动重建
  onTap: logic.login,
))
```

### 在 Logic 中修改

```dart
void togglePasswordType() {
  isPasswordLogin.value = !isPasswordLogin.value;  // 修改 .value 触发 UI 更新
}
```

## 5. 获取依赖 — Get.find

在 View 中通过 `Get.find<T>()` 获取页面控制器：

```dart
class LoginPage extends StatelessWidget {
  final LoginLogic logic = Get.find<LoginLogic>(); // 必须在 Binding 中注册后才能获取
  // ...
}
```

在 Logic 中获取其他控制器：

```dart
class SplashLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  // ...
}
```

## 6. 页面导航 — Get 路由 API

参考 [routing.md](routing.md) 中的完整路由系统设计。

常用导航 API：

| API | 效果 |
|-----|------|
| `Get.toNamed('/route')` | 推入新页面 |
| `Get.offAllNamed('/route')` | 清除整个导航栈并跳转 |
| `Get.offAndToNamed('/route')` | 替换当前页面并跳转 |
| `Get.until((route) => condition)` | 回退直到条件满足 |
| `Get.back()` | 返回上一页 |

## 7. 其他 GetX 特性

### GetBuilder (非响应式)

在 [app_view.dart](../lib/widgets/app_view.dart) 中使用 `GetBuilder` 替代 `Obx`：

```dart
GetBuilder<AppController>(
  init: AppController(),
  builder: (ctrl) => /* UI */
)
```

`GetBuilder` 需要手动调用 `update()` 才会刷新，适合不需要细粒度响应式的场景。

### Get.snackbar (Toast)

在 [login_logic.dart](../lib/pages/login/login_logic.dart#L268) 中使用：

```dart
Get.snackbar('', msg,
  snackPosition: SnackPosition.BOTTOM,
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.black87,
  colorText: Colors.white,
  margin: const EdgeInsets.all(16),
  borderRadius: 8,
);
```

### Get.bottomSheet (底部弹出)

在 [login_logic.dart](../lib/pages/login/login_logic.dart#L206) 中用于国家代码选择器：

```dart
final result = await Get.bottomSheet<String>(Container(...));
if (result != null) areaCode.value = result;
```
