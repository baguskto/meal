import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future getString(String key);
  Future delete(String key);
  Future put(String key, dynamic value);
}

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

  @override
  Future<String> getString(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString(key);
  }

  @override
  Future put(String key, dynamic value) async {
    var shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    }
  }
}
