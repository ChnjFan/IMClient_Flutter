# 登录页 (Login)

## 概述

Login 页是用户认证入口，提供三种登录方式和两种认证模式：

- **三种登录方式**: 手机号、邮箱、账号（通过 TabBar 切换）
- **两种认证模式**: 密码登录（默认）、验证码登录（可切换）
- **辅助功能**: 忘记密码、立即注册（跳转预留路由）

## 文件构成

| 文件 | 路径 | 职责 |
|------|------|------|
| View | [login_view.dart](../../lib/pages/login/login_view.dart) | UI：三标签页表单、注册/忘记密码入口 |
| Logic | [login_logic.dart](../../lib/pages/login/login_logic.dart) | 业务：表单验证、模拟登录、状态管理 |
| Binding | [login_binding.dart](../../lib/pages/login/login_binding.dart) | 依赖注入：`Get.lazyPut(LoginLogic)` |

---

## View 实现 ([login_view.dart](../../lib/pages/login/login_view.dart))

### UI 结构

```
Material
└── TouchCloseSoftKeyboard (渐变背景 + 点击收起键盘)
    └── SingleChildScrollView
        └── Column
            ├── SizedBox (88px 顶部间距)
            ├── Icon (消息 Logo, 64px, 蓝色)
            ├── Text ("欢迎回来", 蓝色半粗体)
            ├── SizedBox (51px)
            ├── Padding (32px 水平)
            │   └── Column
            │       ├── _buildInputView()  ← 240px 高度的输入区域
            │       └── PrimaryButton ("登录")  ← Obx 订阅 enabled 状态
            ├── RichText ("还没有账号？立即注册")  ← 仅手机/邮箱模式显示
            └── Text (版本信息)  ← Obx 订阅 versionInfo
```

### 输入区域 (_buildInputView)

```
SizedBox (height: 240)
└── Column
    ├── TabBar (手机号 / 邮箱 / 账号)
    │   - isScrollable: true
    │   - 点击清除已输入内容
    │   - 切换时收起键盘
    └── Flexible
        └── Obx → TabBarView (不可滑动)
            ├── _buildPhoneEmailInput(LoginType.phone)
            ├── _buildPhoneEmailInput(LoginType.email)
            └── _buildAccountInput()
```

### 手机/邮箱输入区域 (_buildPhoneEmailInput)

```
Column
├── InputBox.account
│   - 手机模式: 显示区号选择器 (+86 ▼)
│   - 邮箱模式: 无区号选择器
├── Offstage → InputBox.password      (isPasswordLogin = true 时显示)
├── Offstage → InputBox.verificationCode  (isPasswordLogin = false 时显示)
└── Row
    ├── GestureDetector → "忘记密码"    (灰色 12sp)
    └── GestureDetector → "验证码登录/密码登录" (蓝色 12sp)
```

### 账号输入区域 (_buildAccountInput)

```
Column
├── InputBox.account (无区号)
└── InputBox.password
```

账号模式下无验证码登录选项、无注册链接。

### 注册弹窗 (_showRegisterBottomSheet)

```
CupertinoActionSheet
├── "邮箱 立即注册" → logic.registerNow()
├── "手机号 立即注册" → logic.registerNow()
└── "取消"
```

### 关键代码片段

**响应式按钮**：
```dart
Obx(() => PrimaryButton(
  text: AppStrings.login,
  enabled: logic.enabled.value,  // 所有必填项非空时为 true
  onTap: logic.login,
))
```

**选项卡切换**：
```dart
TabBar(
  tabs: LoginType.values.map((e) => Tab(text: e.title)).toList(),
  controller: logic.tabController,
  onTap: (index) {
    logic.loginType.value = LoginType.fromRawValue(index);
    FocusScope.of(Get.context!).unfocus();
    logic.phoneCtrl.clear();
    logic.pwdCtrl.clear();
  },
)
```

**Offstage 切换密码/验证码模式**：
```dart
// 密码输入 — 密码模式时显示
Offstage(
  offstage: !logic.isPasswordLogin.value,
  child: InputBox.password(...),
),
// 验证码输入 — 验证码模式时显示
Offstage(
  offstage: logic.isPasswordLogin.value,
  child: InputBox.verificationCode(...),
),
```

---

## Logic 实现 ([login_logic.dart](../../lib/pages/login/login_logic.dart))

### 枚举定义

```dart
enum LoginType {
  phone(0),   // 手机号登录
  email(1),   // 邮箱登录
  account(2); // 账号登录
}

extension LoginTypeExt on LoginType {
  String get title    // "手机号" / "邮箱" / "账号"
  String get hintText // "请输入手机号" / "请输入邮箱" / "请输入账号"
}
```

### 状态管理

| 变量 | 类型 | 说明 |
|------|------|------|
| `phoneCtrl` | `TextEditingController` | 手机号/邮箱/账号输入控制器 |
| `pwdCtrl` | `TextEditingController` | 密码输入控制器 |
| `verificationCodeCtrl` | `TextEditingController` | 验证码输入控制器 |
| `enabled` | `RxBool` | 登录按钮是否可点击 |
| `loginType` | `Rx<LoginType>` | 当前选中的登录方式 |
| `isPasswordLogin` | `RxBool` | 是否密码登录模式（否则验证码模式） |
| `obscureText` | `RxBool` | 密码是否隐藏 |
| `areaCode` | `RxString` | 国家区号（默认 +86） |
| `versionInfo` | `RxString` | 应用版本信息 |
| `tabController` | `TabController` | 选项卡控制器 |
| `accountFocus` / `pwdFocus` | `FocusNode` | 输入焦点控制 |

### 表单验证 (_onChanged)

三个输入框的监听器，根据当前模式判断按钮可用性：

```dart
void _onChanged() {
  if (loginType.value == LoginType.account) {
    // 账号模式：账号 + 密码都非空
    enabled.value = phoneCtrl.text.trim().isNotEmpty &&
                    pwdCtrl.text.trim().isNotEmpty;
  } else {
    // 手机/邮箱模式：
    // 密码模式：账号 + 密码都非空
    // 验证码模式：账号 + 验证码都非空
    enabled.value =
        (isPasswordLogin.value &&
            phoneCtrl.text.trim().isNotEmpty &&
            pwdCtrl.text.trim().isNotEmpty) ||
        (!isPasswordLogin.value &&
            phoneCtrl.text.trim().isNotEmpty &&
            verificationCodeCtrl.text.trim().isNotEmpty);
  }
}
```

### 登录流程 (login)

```
login()
  │
  ├── 保存登录类型到 Storage
  │
  ├── 输入验证
  │   ├── 手机模式: 检查 >= 11 位
  │   ├── 邮箱模式: 检查包含 '@'
  │   └── 账号模式: 检查非空
  │
  ├── 模拟 API 登录 (500ms 延迟)
  │   └── 生成 mock userID + token
  │
  ├── 持久化凭据
  │   ├── Storage.putLoginCertificate(userID, token)
  │   └── Storage.setLoginAccount({...})
  │
  ├── IM 登录
  │   └── imLogic.login(mockUserID, mockToken)
  │
  └── 跳转主页
      └── AppNavigator.startMain()
```

关键代码：

```dart
Future<void> login() async {
  await Storage.setLoginType(loginType.value.rawValue);

  // 输入验证
  if (loginType.value == LoginType.phone) {
    if (phone?.isNotEmpty == true && phoneCtrl.text.length < 11) {
      _showToast('请输入正确的手机号');
      return;
    }
  }
  // ... 邮箱和账号验证类似 ...

  // 模拟 API
  await Future.delayed(const Duration(milliseconds: 500));
  final mockUserID = 'user_${DateTime.now().millisecondsSinceEpoch}';
  final mockToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

  // 持久化 + IM 登录
  await Storage.putLoginCertificate(userID: mockUserID, token: mockToken);
  await Storage.setLoginAccount({
    'areaCode': areaCode.value,
    'phoneNumber': phoneCtrl.text,
    'loginType': loginType.value.rawValue,
  });
  await imLogic.login(mockUserID, mockToken);

  AppNavigator.startMain();
}
```

### 区号选择器 (openCountryCodePicker)

通过 `Get.bottomSheet` 显示底部弹出列表：

```dart
void openCountryCodePicker() async {
  final codes = ['+86', '+852', '+853', '+886', '+1', '+81', '+82', '+44'];
  final result = await Get.bottomSheet<String>(
    Container(
      height: 350,
      child: Column(
        children: [
          // 标题 "选择国家/地区"
          // ListView 列出所有区号
          // 当前选中项显示蓝色勾号
        ],
      ),
    ),
  );
  if (result != null) areaCode.value = result;
}
```

### 验证码发送 (getVerificationCode)

```dart
Future<bool> getVerificationCode() async {
  // 验证手机号/邮箱
  if (phone?.isNotEmpty == true && phoneCtrl.text.length < 11) {
    _showToast('请输入正确的手机号');
    return false;
  }
  // 模拟发送
  await Future.delayed(const Duration(milliseconds: 300));
  _showToast('验证码已发送');
  return true;
}
```

返回值 `bool` 传给 `InputBox.verificationCode`，决定是否启动倒计时。

### 初始数据加载 (_initData)

从 `Storage` 恢复上次登录的账号和登录类型：

```dart
Future<void> _initData() async {
  final map = await Storage.getLoginAccount();
  if (map != null) {
    // 恢复手机号和区号
    if (map['phoneNumber'] != null) phoneCtrl.text = map['phoneNumber'];
    if (map['areaCode'] != null) areaCode.value = map['areaCode'];
  }
  // 恢复登录类型（手机/邮箱/账号）
  loginType.value = LoginType.fromRawValue(await Storage.loginType);
  tabController.index = loginType.value.rawValue;
}
```

---

## Binding 实现 ([login_binding.dart](../../lib/pages/login/login_binding.dart))

```dart
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginLogic());
  }
}
```

---

## 依赖关系

```
LoginPage (View)
  └── Get.find<LoginLogic>()
        ├── Get.find<IMController>()           # IM 登录调用
        ├── Storage (持久化凭据 + 偏好)        # 读写凭据
        ├── PackageInfo (版本信息)
        ├── TextEditingController × 3
        ├── TabController (with GetTickerProviderStateMixin)
        ├── FocusNode × 2
        └── AppNavigator
              ├── startMain()          # 登录成功
              ├── startRegister()      # 立即注册
              └── startForgetPassword() # 忘记密码
```

---

## 与参考项目的差异

| 方面 | 参考项目 | 本项目 |
|------|----------|--------|
| API 调用 | `Apis.login(...)` → 真实后端 | 模拟延迟 + 生成 mock 凭据 |
| 区号选择器 | `IMViews.showCountryCodePicker()` (country_picker 包) | 自定义 `Get.bottomSheet` 列表 |
| 版本信息 | `OpenIM.version` SDK 版本 | `PackageInfo.fromPlatform()` |
| Push 登录 | `PushController.login(...)` FCM 推送 | 未实现 |
| 会话预加载 | `ConversationLogic.getConversationFirstPage()` | 未实现 |
| 错误处理 | `IMViews.showToast()` | `Get.snackbar()` |
| Loading 指示 | `LoadingView.singleton.wrap(...)` | 无（模拟登录无网络延迟） |
| 图片资源 | `ImageRes.loginLogo.toImage` (资源图片) | Material Icon 占位 |
