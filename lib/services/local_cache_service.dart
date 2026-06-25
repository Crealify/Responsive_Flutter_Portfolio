import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle local JSON caching for offline support
class LocalCacheService {
  static final LocalCacheService _instance = LocalCacheService._internal();
  factory LocalCacheService() => _instance;
  LocalCacheService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Saves a list of maps to the cache under the given key
  Future<void> saveList(String key, List<Map<String, dynamic>> data) async {
    await init();
    final String jsonString = jsonEncode(data);
    await _prefs!.setString(key, jsonString);
  }

  /// Retrieves a list of maps from the cache
  Future<List<Map<String, dynamic>>?> getList(String key) async {
    await init();
    final String? jsonString = _prefs!.getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  
  /// Saves a single map to the cache under the given key
  Future<void> saveMap(String key, Map<String, dynamic> data) async {
    await init();
    final String jsonString = jsonEncode(data);
    await _prefs!.setString(key, jsonString);
  }

  /// Retrieves a single map from the cache
  Future<Map<String, dynamic>?> getMap(String key) async {
    await init();
    final String? jsonString = _prefs!.getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        return Map<String, dynamic>.from(jsonDecode(jsonString));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Clears the cache for a specific key
  Future<void> clear(String key) async {
    await init();
    await _prefs!.remove(key);
  }
}
