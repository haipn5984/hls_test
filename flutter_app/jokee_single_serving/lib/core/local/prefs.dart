// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const String _DEVICE_ID_KEY = 'device_id';
  static const String _READ_JOKE_KEY = 'read_joke_id';

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

//Login info
  static Future<bool> saveDeviceId(String value) async {
    final prefs = await _instance;
    return prefs.setString(_DEVICE_ID_KEY, value);
  }

  static Future<bool> saveReadJokeId(String value) async {
    final prefs = await _instance;
    return prefs.setString(_READ_JOKE_KEY, value);
  }

  static String getDeviceId() {
    return _prefsInstance?.getString(_DEVICE_ID_KEY) ?? '';
  }

  static String getReadJoke() {
    return _prefsInstance?.getString(_READ_JOKE_KEY) ?? '';
  }

  //Remove Value
  static Object removeListTempMenu() {
    return _prefsInstance?.remove(_DEVICE_ID_KEY) ?? '';
  }

  static Object removeListMenu() {
    return _prefsInstance?.remove(_READ_JOKE_KEY) ?? '';
  }

  static Future<void> clearData() async {
    await _prefsInstance?.clear();
    return;
  }
}
