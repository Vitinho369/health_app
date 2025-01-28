import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/user_profile_data.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';

class GoalService extends ChangeNotifier {
  UserProfileData? user;
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  VoidCallback progressDailyComplete = () {};

  GoalService() {
    user = sharedPreferencesService.getUser();
  }

  void init() {
    user = sharedPreferencesService.getUser();
    print("entrei na tela de metas, ${user!.toJson()}");
    sharedPreferencesService.initDateGoal();
    DateTime lastDate =
        sharedPreferencesService.getDateGoalLast(); // Data salva
    DateTime today = DateTime.now();

    DateTime lastDateWithoutTime =
        DateTime(lastDate.year, lastDate.month, lastDate.day);
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);

    if (lastDateWithoutTime.isBefore(todayWithoutTime)) {
      user!.progressAliementation = 0;
      user!.progressPhisycalAtivity = 0;
      user!.progressSleep = 0;
      user!.progressWaterIngest = 0;

      sharedPreferencesService.setDateGoalLast(DateTime.now());
      user!.textComplete = false;
      sharedPreferencesService.setUser(user!);
    }
    notifyListeners();
  }

  void verifyProgress() {
    sharedPreferencesService.setUser(user!);
    if (user!.progressPhisycalAtivity >= 1 &&
        user!.progressWaterIngest >= 1 &&
        user!.progressSleep >= 1 &&
        user!.progressAliementation >= 1) {
      progressDailyComplete.call();
      user!.textComplete = true;
      sharedPreferencesService.setDateGoalLast(DateTime.now());
      sharedPreferencesService.setUser(user!);
      notifyListeners();
    }
  }

  void incrementProgressAtivity() {
    user!.progressPhisycalAtivity += 0.2;
    if (user!.progressPhisycalAtivity > 1) user!.progressPhisycalAtivity = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressWaterIngest() {
    user!.progressWaterIngest += 0.05;
    if (user!.progressWaterIngest > 1) user!.progressWaterIngest = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressSleep() {
    user!.progressSleep += 0.15;
    if (user!.progressSleep > 1) user!.progressSleep = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressAliementation() {
    user!.progressAliementation += 0.15;
    if (user!.progressAliementation > 1) user!.progressAliementation = 1;
    verifyProgress();
    notifyListeners();
  }
}
