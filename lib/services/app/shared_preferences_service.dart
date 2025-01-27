import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends ChangeNotifier {
  static SharedPreferences? _sharedPreferences;
  bool? isInstallFit = false;

  SharedPreferencesService() {
    init();
  }

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences?.getBool('isGoogleHealthInstall') == null) {
      await _sharedPreferences?.setBool('isGoogleHealthInstall', false);
    }
  }

  bool isGoogleHealthInstall() {
    isInstallFit = _sharedPreferences?.getBool('isGoogleHealthInstall')!;
    return isInstallFit!;
  }

  Future<void> setGoogleHealthInstall(bool value) async {
    await _sharedPreferences?.setBool('isGoogleHealthInstall', value);
    notifyListeners();
  }

  Future<void> setDateGoalLast(DateTime date) async {
    await _sharedPreferences?.setString('dateGoal', date.toString());
    notifyListeners();
  }

  DateTime getDateGoalLast() {
    final date = _sharedPreferences?.getString('dateGoal');
    return date != null ? DateTime.parse(date) : DateTime.now();
  }

  Future<void> initDateGoal() async {
    if (_sharedPreferences?.getString('dateGoal') == null) {
      await _sharedPreferences?.setString(
          'dateGoal', DateTime.now().toString());
    }
  }
}
