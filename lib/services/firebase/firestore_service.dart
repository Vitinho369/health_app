import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/model/user_profile.dart';

class CloudFiretoreService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final usersRef = FirebaseFirestore.instance.collection('users_profiles');

  Future<void> addUserProfile(
      String weigth, String heigth, String age, String goals) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final String email = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    UserProfileModel userProfileModel = UserProfileModel(
      weigth: double.parse(weigth),
      height: double.parse(heigth),
      age: int.parse(age),
      goals: goals,
    );

    // await usersRef.doc(senderId + email).set({
    //   'weigth': userProfileModel.weigth,
    //   'height': userProfileModel.height,
    //   'age': userProfileModel.age,
    //   'goals': userProfileModel.goals,
    //   'timestamp': timestamp,
    // });
    await _firebaseFirestore.collection("users_profiles").add({
      'weigth': userProfileModel.weigth,
      'height': userProfileModel.height,
      'age': userProfileModel.age,
      'goals': userProfileModel.goals,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return _firebaseFirestore
        .collection("users_profiles")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
