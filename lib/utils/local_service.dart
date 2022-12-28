import 'package:get_storage/get_storage.dart';


import '../models/api/user_info.dart';
import '../models/token/token_manager.dart';

class LocalService {
  static final _box = GetStorage();

  static void save(String key, dynamic value, bool userOnly) {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    _box.write(finalKey, value);
  }

  static dynamic get(String key, bool userOnly) {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    return _box.read(finalKey);
  }
}

