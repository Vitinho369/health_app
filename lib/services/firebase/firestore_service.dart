import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/model/profile.dart';

class CloudFiretoreService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final usersRef = FirebaseFirestore.instance.collection('users_profiles');
  final habitsRef = FirebaseFirestore.instance.collection('habits_user');

  Future<void> addUserProfile(UserProfileModel userProfileModel) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    await usersRef.doc(senderId).set({
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

    await usersRef.doc(senderId).collection("habits_user").doc(habitId).set({
      'exercise': habits.exercise,
      'timeExercise': habits.timeExercise,
      'sleep': habits.sleepDuration,
      'water': habits.waterQtd,
      'timestamp': timestamp,
    }); // merge: true mantém dados existentes
  }

  Stream<DocumentSnapshot> getUserProfile() {
    final String senderId = _firebaseAuth.currentUser!.uid;
    return usersRef.doc(senderId).snapshots();
  }
}
