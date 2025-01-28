import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/model/user_profile_data.dart';
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

  Future<void> setUserSession(String email, String senha) async {
    await _sharedPreferences?.setString('user_session', "${email}_${senha}");
    notifyListeners();
  }

  String? getUserSession() {
    return _sharedPreferences?.getString('user_session');
  }

  Future<void> setUser(UserProfileData user) async {
    print("salvei esses dados: ${user.toJson()}");
    _sharedPreferences?.setString(getUserSession()!, jsonEncode(user.toJson()));
  }

  Future<void> setHabit(Habits habit) async {
    final userHabits = getUser();
    final now = DateTime.now();
    final today = (DateTime(now.year, now.month, now.day)).toString();
    bool exist = false;
    for (final habit in userHabits.habits) {
      if (habit.date.toString() == today) {
        exist = true;
      }
    }

    if (!exist) {
      print("adicionei");
      userHabits.habits.add(habit);
    } else {
      print("atualzei");
      userHabits.habits
          .removeWhere((userHabit) => userHabit.date.toString() == today);
      userHabits.habits.add(habit);

      setUser(userHabits);
    }
  }

  Habits getHabit() {
    final userHabits = getUser();

    final now = DateTime.now();
    final today = (DateTime(now.year, now.month, now.day)).toString();

    for (final habit in userHabits.habits) {
      if (habit.date.toString() == today) {
        return habit;
      }
    }

    return Habits(
      exercise: '',
      timeExercise: 0,
      waterQtd: 0,
      sleepDuration: 0,
      weigth: 0.0,
      date: DateTime.parse(today),
      timestamp: Timestamp.now(),
    );
  }

  UserProfileData getUser() {
    final user = _sharedPreferences?.getString(getUserSession()!);

    return user != null
        ? UserProfileData.fromJson(jsonDecode(user))
        : UserProfileData(
            email: 'a',
            habits: [],
            weigth: 0,
            height: 0,
            age: 0,
            goals: 'a',
            progressPhisycalAtivity: 0,
            progressWaterIngest: 0,
            progressSleep: 0,
            progressAliementation: 0,
            textComplete: false,
          );
  }
}
