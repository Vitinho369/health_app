import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/model/profile.dart';

class CloudFiretoreService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserProfile(UserProfileModel userProfileModel) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

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
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHabits() {
    final String senderId = _firebaseAuth.currentUser!.uid;

    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .orderBy('timestamp',
            descending:
                false) // Ordena os hábitos pela data (mais antigos primeiro)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getHabitData() async* {
    final String senderId = _firebaseAuth.currentUser!.uid;

    final snapshots = _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .collection("habits_user")
        .orderBy('timestamp', descending: false)
        .snapshots();

    await for (final snapshot in snapshots) {
      final data = snapshot.docs
          .map((doc) => doc.data()) // Obtém os dados de cada documento
          .toList();
      yield data;
    }
  }

  Stream<DocumentSnapshot> getUserProfile() {
    final String senderId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection("users_profiles")
        .doc(senderId)
        .snapshots();
  }
}
