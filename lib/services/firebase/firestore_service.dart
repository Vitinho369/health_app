import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/model/profile.dart';
import 'package:health_app/model/user_profile_data.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';

class CloudFiretoreService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final SharedPreferencesService _sharedPreferenceService =
      SharedPreferencesService();

  Future<void> addUserProfile(UserProfileModel userProfileModel) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    UserProfileData user = _sharedPreferenceService.getUser();
    user.weigth = userProfileModel.weigth;
    user.height = userProfileModel.height;
    user.age = userProfileModel.age;
    user.goals = userProfileModel.goals;
    _sharedPreferenceService.setUser(user);
    print(user.toJson());
    await _firebaseFirestore.collection("users_profiles").doc(senderId).set({
      'weigth': userProfileModel.weigth,
      'height': userProfileModel.height,
      'age': userProfileModel.age,
      'goals': userProfileModel.goals,
      'timestamp': timestamp,
    });
  }

  Future<void> addHabit(Habits habits) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    final String habitId = '$day-$month-$year';

    UserProfileData user = _sharedPreferenceService.getUser();
    habits.timestamp = timestamp;
    print("Habito adicionado: ${habits.toJson()}");
    user.habits.add(habits);
    _sharedPreferenceService.setUser(user);
    print("Habito adicionado: ${_sharedPreferenceService.getUser().toJson()}");

    await _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .doc(habitId)
        .set({
      'exercise': habits.exercise,
      'timeExercise': habits.timeExercise,
      'sleep': habits.sleepDuration,
      'water': habits.waterQtd,
      'weigth': habits.weigth,
      'date': habits.date,
      'timestamp': timestamp,
    });
  }

  Future<void> syncSharedBanck(UserProfileData user) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    print("Peso: ${user.weigth}");
    await _firebaseFirestore.collection("users_profiles").doc(senderId).set({
      'weigth': user.weigth,
      'height': user.height,
      'age': user.age,
      'goals': user.goals,
      'timestamp': timestamp,
    });

    print("Habitos: ${user.habits}");

    // for (var habit in user.habits) {
    //   final day = habit.date!.day;
    //   final month = habit.date!.month;
    //   final year = habit.date!.year;
    //   final String habitId = '$day-$month-$year';
    //   await _firebaseFirestore
    //       .collection("users_profiles")
    //       .doc(senderId)
    //       .collection("habits_user")
    //       .doc(habitId)
    //       .set({
    //     'exercise': habit.exercise,
    //     'timeExercise': habit.timeExercise,
    //     'sleep': habit.sleepDuration,
    //     'water': habit.waterQtd,
    //     'weigth': habit.weigth,
    //     'date': habit.date,
    //     'timestamp': habit.timestamp,
    //   });
    // }
  }

  Future<void> addGoal(Habits habits) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    final String habitId = '$day-$month-$year';
    await _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .doc(habitId)
        .set({
      'exercise': habits.exercise,
      'timeExercise': habits.timeExercise,
      'sleep': habits.sleepDuration,
      'water': habits.waterQtd,
      'date': habits.date,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHabits() {
    final String senderId = _firebaseAuth.currentUser!.uid;

    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodayHabits() {
    final String senderId = _firebaseAuth.currentUser!.uid;

    // Data de hoje no formato ISO para comparação
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .where('timestamp', isLessThanOrEqualTo: endOfDay)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getHabitData() {
    final String senderId = _firebaseAuth.currentUser!.uid;
    print("chamei a função de get habit data");
    print(_sharedPreferenceService.getUser().toJson());
    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<DocumentSnapshot> getUserProfile() {
    final String senderId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .snapshots();
  }
}
