import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/user_profile_data.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  final CloudFiretoreService firetoreService = CloudFiretoreService();

  bool loginSucess = true;
  bool permissionLogin = false;
  bool registerSucess = true;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _sharedPreferencesService.setUserSession(email, password);
      List<String> userSession =
          _sharedPreferencesService.getUserSession()!.split("_");
      if (userSession[0] == email && userSession[1] == password) {
        UserProfileData user = _sharedPreferencesService.getUser();
        user.email = email;
        print("usuário login: ${user.toJson()}");
        _sharedPreferencesService.setUser(user);
        firetoreService.syncSharedBanck(user);
      }
      loginSucess = true;
      permissionLogin = true;
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      // if (_sharedPreferencesService.getUserSession() != null) {
      //   List<String> user =
      //       _sharedPreferencesService.getUserSession()!.split("_");

      //   if (email == user[0] && password == user[1]) {
      //     permissionLogin = true;
      //     _sharedPreferencesService.setUserSession(email, password);

      //     UserProfileData user = _sharedPreferencesService.getUser();
      //     user.email = email;

      //     _sharedPreferencesService.setUser(user);
      //     notifyListeners();
      //     return null;
      //   }
      // }
      permissionLogin = false;
      loginSucess = false;
      notifyListeners();
      throw Exception(e.message);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      registerSucess = true;
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      registerSucess = false;
      notifyListeners();
      throw Exception(e.message);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    permissionLogin = false;
    notifyListeners();
  }

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser!.email;
  }
}
