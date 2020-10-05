import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';

class SecureStorageService {
  static FlutterSecureStorage _preferences;
  static SecureStorageService _instance;

  static Future<SecureStorageService> getInstance() async {
    if (_instance == null) {
      _instance = SecureStorageService();
    }

    if (_preferences == null) {
      _preferences = FlutterSecureStorage();
    }

    return _instance;
  }

  //set and get for emailBiometric
  Future<String> get emailBiometric async =>
      await _getFromDisk(EMAILFORBIOMETRIC);
  Future setEmailBiometric(String email) async {
    await _saveToDisk(EMAILFORBIOMETRIC, email);
  }

  //set and get for passwordBiometric
  Future<String> get passwordBiometric async =>
      await _getFromDisk(PASSWORDFORBIOMETRIC);
  Future setPasswordBiometric(String password) async {
    await _saveToDisk(PASSWORDFORBIOMETRIC, password);
  }

  //set and get current password
  //for add fingerprint in settings
  Future<String> get currentPassword async =>
      await _getFromDisk(CURRENTPASSWORD);
  Future setCurrentPassword(String password) async {
    await _saveToDisk(CURRENTPASSWORD, password);
  }

  //get/read from disk
  Future<String> _getFromDisk(String key) async {
    var value = await _preferences.read(key: key);
    print('(TRACE) SecureStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  //save/write to disk
  Future _saveToDisk<T>(String key, String value) async {
    print(
        '(TRACE) SecureStorageService:_saveStringToDisk. key: $key value: $value');
    await _preferences.write(key: key, value: value);
  }
}
