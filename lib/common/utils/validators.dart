/// 全局文本验证工具。
///
/// 用于判断输入文本的类型，如邮箱、手机号等。
class Validators {
  Validators._();

  /// 判断是否为邮箱地址。
  static bool isEmail(String text) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(text.trim());
  }

  /// 判断是否为手机号（中国大陆 11 位数字）。
  static bool isPhoneNumber(String text) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(text.trim());
  }

  /// 判断是否为纯数字 ID。
  static bool isNumericId(String text) {
    return RegExp(r'^\d+$').hasMatch(text.trim());
  }

  /// 将服务端返回的时间字符串（如 "2026-06-21 19:21:31"）转为毫秒时间戳。
  ///
  /// 若字符串为 null 或为空，返回 0。
  static int parseTimeToMs(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return 0;
    return DateTime.tryParse(timeStr)?.millisecondsSinceEpoch ?? 0;
  }

  /// 识别输入文本类型。
  static InputType identify(String text) {
    final trimmed = text.trim();
    if (isEmail(trimmed)) return InputType.email;
    if (isPhoneNumber(trimmed)) return InputType.phone;
    if (isNumericId(trimmed)) return InputType.numericId;
    return InputType.text;
  }
}

enum InputType {
  email,
  phone,
  numericId,
  text,
}
