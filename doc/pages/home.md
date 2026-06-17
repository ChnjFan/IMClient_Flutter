# 主页框架 (Home)

## 概述

Home 页是登录成功后的主界面框架，提供底部三标签页导航（消息、通讯录、我的）。当前为占位实现，每个标签页显示图标和文字占位符。

## 文件构成

| 文件 | 路径 | 职责 |
|------|------|------|
| View | [home_view.dart](../../lib/pages/home/home_view.dart) | UI：底部导航栏 + IndexedStack 占位 |
| Logic | [home_logic.dart](../../lib/pages/home/home_logic.dart) | 业务：标签页索引切换 |
| Binding | [home_binding.dart](../../lib/pages/home/home_binding.dart) | 依赖注入：`Get.lazyPut(HomeLogic)` |

---

## View 实现 ([home_view.dart](../../lib/pages/home/home_view.dart))

### UI 结构

```
Scaffold
├── body: Obx → IndexedStack
│   ├── [0] 消息占位页  (chat icon + 文字)
│   ├── [1] 通讯录占位页 (contacts icon + 文字)
│   └── [2] 我的占位页  (person icon + 文字)
│
└── bottomNavigationBar: Obx → BottomNavigationBar
    ├── 消息 (Icons.chat_bubble_outline / chat_bubble)
    ├── 通讯录 (Icons.contacts_outlined / contacts)
    └── 我的 (Icons.person_outline / person)
```

### 关键代码

```dart
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeLogic logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(
        () => IndexedStack(
          index: logic.index.value,
          children: [
            _buildPlaceholderTab('消息', AppImages.homeTabSel),
            _buildPlaceholderTab('通讯录', AppImages.contactsTabSel),
            _buildPlaceholderTab('我的', AppImages.mineTabSel),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: logic.index.value,
          onTap: logic.switchTab,
          selectedItemColor: AppColors.c_0089FF,
          unselectedItemColor: AppColors.c_8E9AB0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(AppImages.homeTabNor),
              activeIcon: Icon(AppImages.homeTabSel),
              label: '消息',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppImages.contactsTabNor),
              activeIcon: Icon(AppImages.contactsTabSel),
              label: '通讯录',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppImages.mineTabNor),
              activeIcon: Icon(AppImages.mineTabSel),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: AppColors.c_0089FF_opacity10),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16, color: AppColors.c_8E9AB0)),
        ],
      ),
    );
  }
}
```

### 设计要点

- **IndexedStack**: 保持所有标签页的 Widget 状态，切换时不销毁
- **Obx 包裹**: 响应式更新当前显示的标签页和底部导航选中态
- **activeIcon / icon**: 分别指定选中和未选中的图标，提升视觉反馈

---

## Logic 实现 ([home_logic.dart](../../lib/pages/home/home_logic.dart))

### 代码

```dart
class HomeLogic extends GetxController {
  final index = 0.obs;       // 当前选中的标签页索引

  void switchTab(int idx) {
    index.value = idx;       // 修改 .obs 变量触发 UI 刷新
  }
}
```

当前为最简实现。参考项目的 `HomeLogic` 还包含：
- 未读消息数统计
- 好友/群组申请未处理数
- 锁屏密码检查
- 生物识别认证
- RTC 通话邀请处理
- IM SDK 状态监听

这些将在后续迭代中实现。

---

## Binding 实现 ([home_binding.dart](../../lib/pages/home/home_binding.dart))

```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
  }
}
```

---

## 导航

登录成功后通过 `AppNavigator.startMain()` 或 `AppNavigator.startSplashToMain()` 进入。

携带参数示例：
```dart
Get.offAllNamed(
  AppRoutes.home,
  arguments: {'isAutoLogin': true},
);
```

在 `home_logic.dart` 中读取：
```dart
@override
void onInit() {
  _isAutoLogin = Get.arguments != null ? Get.arguments['isAutoLogin'] : false;
  super.onInit();
}
```

---

## 待实现功能

参考 openim-flutter-demo 的 Home 页，后续需要添加：

| 功能 | 说明 |
|------|------|
| 会话列表 | 替换"消息"占位页，展示最近聊天会话 |
| 通讯录 | 替换"通讯录"占位页，展示好友/群组/组织架构 |
| 个人中心 | 替换"我的"占位页，展示用户信息/设置入口 |
| 未读角标 | 标签页图标上的未读消息数/申请数角标 |
| 锁屏密码 | `flutter_screen_lock` 应用锁 |
| 生物识别 | `local_auth` 指纹/面容解锁 |
| 通知权限 | `flutter_local_notifications` 本地通知 |
| 音频会话 | `audio_session` / `just_audio` 消息提示音 |
| 震动 | `vibration` 消息震动 |
| 前后台切换 | 在后台时显示本地通知 |
