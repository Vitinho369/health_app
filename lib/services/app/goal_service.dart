import 'package:flutter/material.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';

class GoalService extends ChangeNotifier {
  double progressPhisycalAtivity = 0;
  double progressWaterIngest = 0;
  double progressSleep = 0;
  double progressAliementation = 0;
  bool textComplete = false;
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  VoidCallback progressDailyComplete = () {};

  void init() {
    sharedPreferencesService.initDateGoal();
    DateTime lastDate =
        sharedPreferencesService.getDateGoalLast(); // Data salva
    DateTime today = DateTime.now();

    DateTime lastDateWithoutTime =
        DateTime(lastDate.year, lastDate.month, lastDate.day);
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);

    if (lastDateWithoutTime.isBefore(todayWithoutTime)) {
      progressPhisycalAtivity = 0;
      progressWaterIngest = 0;
      progressSleep = 0;
      progressAliementation = 0;
      sharedPreferencesService.setDateGoalLast(DateTime.now());
      textComplete = false;
      notifyListeners();
    }
  }

  void verifyProgress() {
    if (progressPhisycalAtivity >= 1 &&
        progressWaterIngest >= 1 &&
        progressSleep >= 1 &&
        progressAliementation >= 1) {
      progressDailyComplete.call();
      textComplete = true;
      sharedPreferencesService.setDateGoalLast(DateTime.now());
      notifyListeners();
    }
  }

  void incrementProgressAtivity() {
    progressPhisycalAtivity += 0.2;
    if (progressPhisycalAtivity > 1) progressPhisycalAtivity = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressWaterIngest() {
    progressWaterIngest += 0.05;
    if (progressWaterIngest > 1) progressWaterIngest = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressSleep() {
    progressSleep += 0.15;
    if (progressSleep > 1) progressSleep = 1;
    verifyProgress();
    notifyListeners();
  }

  void incrementProgressAliementation() {
    progressAliementation += 0.15;
    if (progressAliementation > 1) progressAliementation = 1;
    verifyProgress();
    notifyListeners();
  }
}
