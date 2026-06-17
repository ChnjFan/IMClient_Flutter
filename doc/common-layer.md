# 公共层（Common Layer）

公共层提供所有页面共用的资源、样式、工具类和通用 UI 组件。

## 资源常量 (`common/res/`)

### Gaps — 间距常量 ([gaps.dart](../lib/common/res/gaps.dart))

预创建的 `SizedBox` 小部件，用于快速添加间距，避免在代码中写死数字：

```dart
// 垂直间距
static const Widget vGap4 = SizedBox(height: 4);
static const Widget vGap8 = SizedBox(height: 8);
static const Widget vGap10 = SizedBox(height: 10);
static const Widget vGap12 = SizedBox(height: 12);
static const Widget vGap16 = SizedBox(height: 16);
static const Widget vGap24 = SizedBox(height: 24);
static const Widget vGap32 = SizedBox(height: 32);
static const Widget vGap40 = SizedBox(height: 40);
static const Widget vGap46 = SizedBox(height: 46);
static const Widget vGap51 = SizedBox(height: 51);
static const Widget vGap64 = SizedBox(height: 64);
static const Widget vGap88 = SizedBox(height: 88);
static const Widget vGap100 = SizedBox(height: 100);

// 水平间距
static const Widget hGap4 = SizedBox(width: 4);
static const Widget hGap8 = SizedBox(width: 8);
static const Widget hGap10 = SizedBox(width: 10);
static const Widget hGap12 = SizedBox(width: 12);
static const Widget hGap16 = SizedBox(width: 16);
```

**使用方式**：在 Column/Row 的 children 中插入即可。

### Images — 图标引用 ([images.dart](../lib/common/res/images.dart))

使用 Material Icons 作为占位图标（后续可替换为实际图片资源）：

```dart
class AppImages {
  // 启动页
  static const IconData splashLogo = Icons.chat_bubble_rounded;

  // 登录页
  static const IconData loginLogo = Icons.message_rounded;

  // 主页标签
  static const IconData homeTabNor = Icons.chat_bubble_outline;
  static const IconData homeTabSel = Icons.chat_bubble;
  static const IconData contactsTabNor = Icons.contacts_outlined;
  static const IconData contactsTabSel = Icons.contacts;
  static const IconData mineTabNor = Icons.person_outline;
  static const IconData mineTabSel = Icons.person;
}
```

### Strings — UI 字符串 ([strings.dart](../lib/common/res/strings.dart))

所有 UI 文本集中管理（当前为中文，为后续国际化预留扩展点）：

```dart
class AppStrings {
  // 通用
  static const String confirm = '确认';
  static const String cancel = '取消';
  static const String loading = '加载中...';

  // 启动页
  static const String appSlogan = '即时通讯，随时随地';

  // 登录页
  static const String welcome = '欢迎回来';
  static const String login = '登录';
  static const String phoneNumber = '手机号';
  static const String email = '邮箱';
  static const String account = '账号';
  static const String plsEnterPhoneNumber = '请输入手机号';
  static const String plsEnterEmail = '请输入邮箱';
  static const String plsEnterAccount = '请输入账号';
  static const String plsEnterPassword = '请输入密码';
  static const String plsEnterVerificationCode = '请输入验证码';
  static const String plsEnterRightPhone = '请输入正确的手机号';
  static const String plsEnterRightEmail = '请输入正确的邮箱';
  static const String plsEnterRightAccount = '请输入正确的账号';
  static const String passwordLogin = '密码登录';
  static const String verificationCodeLogin = '验证码登录';
  static const String verificationCode = '验证码';
  static const String sendVerificationCode = '发送验证码';
  static const String forgetPassword = '忘记密码';
  static const String noAccountYet = '还没有账号？';
  static const String registerNow = '立即注册';
  static const String through = '通过%s';

  // 主页
  static const String home = '消息';
  static const String contacts = '通讯录';
  static const String mine = '我的';
}
```

---

## 样式常量 (`common/styles/`)

### Colors — 颜色调色板 ([colors.dart](../lib/common/styles/colors.dart))

命名规则：`c_` 前缀 + 十六进制色值（与参考项目保持一致）：

```dart
class AppColors {
  // 主色
  static const Color c_0089FF = Color(0xFF0089FF);
  static const Color c_0089FF_opacity10 = Color(0x1A0089FF);  // 10% 透明度

  // 中性色
  static const Color c_FFFFFF = Color(0xFFFFFFFF);
  static const Color c_FFFFFF_opacity0 = Color(0x00FFFFFF);
  static const Color c_0C1C33 = Color(0xFF0C1C33);
  static const Color c_8E9AB0 = Color(0xFF8E9AB0);
  static const Color c_F0F2F6 = Color(0xFFF0F2F6);
  static const Color c_E8EAEF = Color(0xFFE8EAEF);
  static const Color c_333333 = Color(0xFF333333);
  static const Color c_666666 = Color(0xFF666666);
  static const Color c_999999 = Color(0xFF999999);
  static const Color c_418AE5 = Color(0xFF418AE5);

  // 语义色
  static const Color c_FF381F = Color(0xFFFF381F);  // 红色/错误
  static const Color c_10CC64 = Color(0xFF10CC64);  // 绿色/成功
}
```

### TextStyles — 文本样式 ([text_styles.dart](../lib/common/styles/text_styles.dart))

命名规则：`ts_` 前缀 + 色值 + 字号 + 字重：

```dart
class AppTextStyles {
  // 17sp 半粗体 蓝色 — 用于标题文字
  static const ts_0089FF_17sp_semibold = TextStyle(
    color: AppColors.c_0089FF, fontSize: 17, fontWeight: FontWeight.w600,
  );

  // 12sp 灰色 — 用于辅助文字
  static const ts_8E9AB0_12sp = TextStyle(
    color: AppColors.c_8E9AB0, fontSize: 12,
  );

  // 12sp 蓝色 — 用于可点击文字
  static const ts_0089FF_12sp = TextStyle(
    color: AppColors.c_0089FF, fontSize: 12,
  );

  // 14sp 深色 — 用于正文
  static const ts_0C1C33_14sp = TextStyle(
    color: AppColors.c_0C1C33, fontSize: 14,
  );

  // 10sp 半粗体 蓝色 — 用于底部导航标签
  static const ts_0089FF_10sp_semibold = TextStyle(
    color: AppColors.c_0089FF, fontSize: 10, fontWeight: FontWeight.w600,
  );
}
```

---

## 工具类 (`common/utils/`)

### Logger — 日志 ([logger.dart](../lib/common/utils/logger.dart))

仅在 Debug 模式下输出，带 `[IMClient]` 前缀：

```dart
class Logger {
  static void print(String message, {bool onlyConsole = false}) {
    if (kDebugMode) {
      debugPrint('[IMClient] $message');
    }
  }
}
```

**使用场景**：`main.dart` 中的 Flutter 错误、各控制器中的关键事件。

### Storage — 持久化存储 ([storage.dart](../lib/common/utils/storage.dart))

对 `SharedPreferences` 的封装，管理登录凭据和账户信息：

| 方法 | 说明 |
|------|------|
| `userID` / `setUserID()` | 用户 ID 读写 |
| `token` / `setToken()` | IM Token 读写 |
| `areaCode` / `setAreaCode()` | 国家区号读写（默认 +86） |
| `phoneNumber` / `setPhoneNumber()` | 手机号读写 |
| `loginType` / `setLoginType()` | 登录类型读写（int: 0=手机 1=邮箱 2=账号） |
| `getLoginAccount()` / `setLoginAccount()` | 完整账户信息（JSON）读写 |
| `putLoginCertificate({userID, token})` | 保存登录凭据的组合方法 |
| `removeLoginCertificate()` | 清除所有登录凭据 |

**调用方**：
- `IMController` — 登录/登出时持久化/清除凭据
- `SplashLogic` — 检查是否有已存储凭据以自动登录
- `LoginLogic` — 登录成功后保存凭据和偏好设置

---

## 通用组件 (`common/widgets/`)

### PrimaryButton — 主按钮 ([button.dart](../lib/common/widgets/button.dart))

带渐变背景的操作按钮，支持启用/禁用状态：

```dart
PrimaryButton(
  text: '登录',
  enabled: logic.enabled.value,   // false 时灰显且不可点击
  onTap: logic.login,
  // 可选参数:
  // width: ...    // 宽度，默认 null (自适应)
  // height: 48,   // 高度，默认 48
  // borderRadius: 8, // 圆角，默认 8
)
```

**实现细节**：
- 启用态：蓝色到浅蓝色线性渐变（`c_0089FF` → `c_418AE5`）
- 禁用态：纯灰色（`c_8E9AB0`）
- 使用 `InkWell` 提供水波纹点击效果

### InputBox — 输入框组 ([input_box.dart](../lib/common/widgets/input_box.dart))

三种类型的输入框，全部通过静态方法创建：

#### 1. `InputBox.account()` — 账号输入框

```dart
InputBox.account(
  label: '',                    // 标签文字（空字符串则隐藏）
  hintText: '请输入手机号',
  controller: logic.phoneCtrl,
  focusNode: logic.accountFocus,
  keyBoardType: TextInputType.phone,
  code: '+86',                  // 区号（可选）
  onAreaCode: logic.openCountryCodePicker,  // 点击区号回调（可选）
)
```

**特性**：带区号选择器的前缀区域（分隔线 + 下拉箭头）。

#### 2. `InputBox.password()` — 密码输入框

```dart
InputBox.password(
  label: '',
  hintText: '请输入密码',
  controller: logic.pwdCtrl,
  focusNode: logic.pwdFocus,
  obscureText: true,                    // 是否隐藏密码
  onToggleObscure: () => ...,           // 点击眼睛图标回调
)
```

**特性**：右侧眼睛图标切换密码可见性。

#### 3. `InputBox.verificationCode()` — 验证码输入框

```dart
InputBox.verificationCode(
  label: '验证码',
  hintText: '请输入验证码',
  controller: logic.verificationCodeCtrl,
  onSendVerificationCode: logic.getVerificationCode,
  countdownSeconds: 60,   // 倒计时秒数，默认 60
)
```

**特性**：
- 右侧"发送验证码"按钮，发送后显示倒计时（如 `58s`）
- 倒计时期间按钮不可点击
- 发送中显示 `CircularProgressIndicator`
- 通过回调函数获取发送结果（返回 `Future<bool>`）

### TouchCloseSoftKeyboard — 键盘收起 ([touch_close_soft_keyboard.dart](../lib/common/widgets/touch_close_soft_keyboard.dart))

包裹页面内容，点击非输入区域时收起键盘：

```dart
TouchCloseSoftKeyboard(
  isGradientBg: true,   // 是否显示从蓝到透明的渐变背景
  child: /* 页面内容 */,
)
```

**实现**：`GestureDetector` + `HitTestBehavior.translucent`，在 `onTap` 中调用 `FocusScope.of(context).unfocus()`。
