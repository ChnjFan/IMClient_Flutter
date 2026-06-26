/// 时间格式化工具。
class TimeUtils {
  TimeUtils._();

  // ---- 解析 ----

  /// 将服务端返回的时间字符串解析为毫秒时间戳。
  ///
  /// 服务端时间格式通常为 "2026-06-21 19:21:31"。
  /// 若 [timeStr] 为 null 或为空，返回 null；解析失败时也返回 null。
  static int? parseServerTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    return DateTime.tryParse(timeStr)?.millisecondsSinceEpoch;
  }

  // ---- 格式化 ----

  /// 将毫秒时间戳格式化为相对时间展示文本。
  ///
  /// - 小于 1 分钟 → "刚刚"
  /// - 小于 1 小时 → "N分钟前"
  /// - 小于 1 天   → "N小时前"
  /// - 小于 30 天  → "N天前"
  /// - 其他        → "yyyy-MM-dd"
  ///
  /// [timestampMs] 为 0 或负数时返回空字符串。
  static String formatRelativeTime(int timestampMs) {
    if (timestampMs <= 0) return '';
    final now = DateTime.now();
    final dt = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    if (diff.inDays < 30) return '${diff.inDays}天前';

    return _formatDate(dt);
  }

  /// 将毫秒时间戳格式化为 "yyyy-MM-dd"。
  ///
  /// [timestampMs] 为 0 或负数时返回空字符串。
  static String formatDate(int timestampMs) {
    if (timestampMs <= 0) return '';
    return _formatDate(DateTime.fromMillisecondsSinceEpoch(timestampMs));
  }

  /// 混合解析并格式化为 "yyyy-MM-dd"。
  ///
  /// [timeStr] 可能是：
  /// - 毫秒时间戳字符串（纯数字）
  /// - ISO 日期时间字符串（如 "2026-06-21 19:21:31" 或 "2026-06-21T19:21:31"）
  /// - 其他格式
  ///
  /// 若解析失败，尝试按前 10 位截取；完全无法识别时返回 "未知"。
  static String formatDateFromString(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '未知';
    // 尝试作为毫秒时间戳解析
    final ms = int.tryParse(timeStr);
    if (ms != null) return formatDate(ms);
    // 尝试作为 DateTime 字符串解析
    final dt = DateTime.tryParse(timeStr);
    if (dt != null) return _formatDate(dt);
    // 兜底：截取前 10 位（如 "2026-06-25..."）
    if (timeStr.length >= 10) return timeStr.substring(0, 10);
    return timeStr;
  }

  /// 将毫秒时间戳转换为服务端时间字符串格式。
  ///
  /// 输出格式为 "yyyy-MM-dd HH:mm:ss"，是 [parseServerTime] 的逆操作。
  /// [timestampMs] 为 0 或负数时返回空字符串。
  static String toServerTimeString(int timestampMs) {
    if (timestampMs <= 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  // ---- 内部 ----

  static String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
