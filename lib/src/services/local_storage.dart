import 'package:get_storage/get_storage.dart';

enum LocalStorageKey{intro, token}

class LocalStorage{
  static final _box = GetStorage();

  static saveData({required LocalStorageKey key, required dynamic data})async{
    await _box.write(key.toString(), data);
  }

  static getData({required LocalStorageKey key}){
    return _box.read(key.toString());
  }

  static removeData({required LocalStorageKey key})async{
    await _box.remove(key.toString());
  }
}