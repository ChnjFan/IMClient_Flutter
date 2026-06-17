import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences for storing user credentials
/// and server configuration.
class Storage {
  Storage._();

  static SharedPreferences? _prefs;

  static const _keyUserID = 'user_id';
  static const _keyToken = 'im_token';
  static const _keyAreaCode = 'area_code';
  static const _keyPhoneNumber = 'phone_number';
  static const _keyLoginType = 'login_type';
  static const _keyLoginAccount = 'login_account';
  static const _keyServerHost = 'server_host';
  static const _keyServerConfig = 'server_config';

  // ---- Init ----

  /// Initialise SharedPreferences. Must be called once before any read/write.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---- User ID ----

  static Future<String?> get userID async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserID);
  }

  static Future<void> setUserID(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserID, value);
  }

  // ---- Token ----

  static Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, value);
  }

  // ---- Area Code ----

  static Future<String> get areaCode async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAreaCode) ?? '+86';
  }

  static Future<void> setAreaCode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAreaCode, value);
  }

  // ---- Phone Number ----

  static Future<String?> get phoneNumber async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhoneNumber);
  }

  static Future<void> setPhoneNumber(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPhoneNumber, value);
  }

  // ---- Login Type ----

  static Future<int> get loginType async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyLoginType) ?? 0;
  }

  static Future<void> setLoginType(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLoginType, value);
  }

  // ---- Login Account Map ----

  static Future<Map<String, dynamic>?> getLoginAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keyLoginAccount);
    if (str == null) return null;
    try {
      return jsonDecode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> setLoginAccount(Map<String, dynamic> map) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLoginAccount, jsonEncode(map));
  }

  // ---- Convenience ----

  /// Save login credentials after successful login.
  static Future<void> putLoginCertificate({
    required String userID,
    required String token,
  }) async {
    await setUserID(userID);
    await setToken(token);
  }

  /// Clear all stored login credentials.
  static Future<void> removeLoginCertificate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserID);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyLoginAccount);
  }

  // ---- Server Config ----

  /// Synchronous read of the server host (requires [init] called first).
  static String? getServerHostSync() {
    return _prefs?.getString(_keyServerHost);
  }

  /// Synchronous read of the full server config map (requires [init] called first).
  static Map<String, dynamic>? getServerConfigSync() {
    final str = _prefs?.getString(_keyServerConfig);
    if (str == null) return null;
    try {
      return jsonDecode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Set the full server config map.
  static Future<void> setServerConfig(Map<String, dynamic> config) async {
    _prefs?.setString(_keyServerConfig, jsonEncode(config));
    if (config['serverHost'] is String) {
      _prefs?.setString(_keyServerHost, config['serverHost'] as String);
    }
  }
}
