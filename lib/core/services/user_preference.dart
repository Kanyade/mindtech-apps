import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceKeys {
  static const String isFirstRun = 'is_first_run';
  static const String userAccount = 'user_account';
}

class UserPreferences {
  UserPreferences(this._flutterSecureStorage, this._preferences);

  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _preferences;

  Future<bool> containsEncrypted({required String key}) => _flutterSecureStorage.containsKey(key: key);

  Future<String?> readEncrypted({required String key}) => _flutterSecureStorage.read(key: key);
  Future<void> writeEncrypted({required String key, required String value}) =>
      _flutterSecureStorage.write(key: key, value: value);

  Future<void> deleteEncrypted({required String key}) => _flutterSecureStorage.delete(key: key);
  Future<void> deleteAllEncrypted() => _flutterSecureStorage.deleteAll();

  bool containsUnencrypted({required String key}) => _preferences.containsKey(key);

  String? readUnencrypted(String key) => _preferences.getString(key);
  Future<bool> writeUnencrypted(String key, String value) => _preferences.setString(key, value);

  bool? readBoolUnencrypted(String key) => _preferences.getBool(key);
  Future<bool> writeBoolUnencrypted(String key, {required bool value}) async => _preferences.setBool(key, value);

  Future<bool> deleteUnencrypted(String key) => _preferences.remove(key);
  Future<bool> deleteAllUnencrypted() => _preferences.clear();
}
