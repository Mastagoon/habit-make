import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// a class to manage shared prefs. saves data as a json string
class SharedPrefs {
  static get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key).toString());
  }

  static set(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
