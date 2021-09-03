import 'package:shared_preferences/shared_preferences.dart';

class ClockPreferences {
  static SharedPreferences? _preferences;
  static const _keyTimeSet = "timeSet";
  static const _keyTAWSet = "currentAlarmTimeSet";
  static const _keyIsRunning = "isRunningKey";
  static const _keyHasAllowed = "hasBeenAllowed";

  static String _keyDuration = "duration";
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTime(int time) async =>
      await _preferences!.setInt(_keyTimeSet, time);
  static int? getTimeSet() => _preferences!.getInt(_keyTimeSet);
  static Future setTAWSet(DateTime timeAlarmSet) async {
    final timeAWSet = timeAlarmSet.toIso8601String();
    await _preferences!.setString(_keyTAWSet, timeAWSet);
  }
  static Future setHasAllowedPerms(bool hasAllowed) async =>
  await _preferences!.setBool(_keyHasAllowed, hasAllowed);
  static bool? getHasAllowedPerms() =>
  _preferences!.getBool(_keyHasAllowed);
  static Future setDuration(int duration) async {
    await _preferences!.setInt(_keyDuration, duration);
  }

  static int? getDuration() => _preferences!.getInt(_keyDuration);
  static DateTime? getTAWSet() {
    final time = _preferences!.getString(_keyTAWSet);
    return DateTime.tryParse(time!);
  }

  static Future setIsRunning(bool isRunning) async =>
      await _preferences!.setBool(_keyIsRunning, isRunning);

  static bool? getIsRunning() => _preferences!.getBool(_keyIsRunning);
}
