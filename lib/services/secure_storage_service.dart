import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';

class SecureStorageService {
  static FlutterSecureStorage _preferences = FlutterSecureStorage();

  //set and get for emailBiometric
  String get emailBiometric => _getFromDisk(emailForBiometric) ?? false;
  set emailBiometric(String value) => _saveToDisk(emailForBiometric, value);

  //set and get for passwordBiometric
  String get passwordBiometric => _getFromDisk(passwordForBiometric) ?? false;
  set passwordBiometric(String value) =>
      _saveToDisk(passwordForBiometric, value);

  //get/read from disk
  dynamic _getFromDisk(String key) {
    var value = _preferences.read(key: key);
    print('(TRACE) SecureStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  //save/write to disk
  void _saveToDisk<T>(String key, String value) {
    print(
        '(TRACE) SecureStorageService:_saveStringToDisk. key: $key value: $value');
    _preferences.write(key: key, value: value);
  }
}
