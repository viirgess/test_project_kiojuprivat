abstract class KeyValueStore {
  Future<void> setString(String key, String value);
  String? getString(String key);

  Future<void> setBool(String key, bool value);
  bool? getBool(String key);
}

