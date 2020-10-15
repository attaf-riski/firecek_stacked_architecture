import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences _preferences;
  static LocalStorageService _instance;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  List<String> _getFromDiskForListString(String key) {
    List<String> value = _preferences.getStringList(key);
    print(
        '(TRACE) LocalStorageService:_getFromDiskForListString. key: $key value: $value');
    return value;
  }

  Future _saveToDisk<T>(String key, T content) async {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  //getter and setter for has setup biometric or not
  bool get hasSetupBiometric => _getFromDisk(HASSETUPBIOMETRIC) ?? false;
  set hasSetupBiometric(bool value) => _saveToDisk(HASSETUPBIOMETRIC, value);

  //getter and setter for is has subcribe to this topic or not
  bool isSubscribeToThisTopic(String productKey) =>
      _getFromDisk(ISSUBSCRIBETOTHISTOPIC + productKey) ?? false;
  Future setIsSubscribeToThisTopic(String productKey, bool value) async {
    await _saveToDisk(ISSUBSCRIBETOTHISTOPIC + productKey, value);
  }
}
