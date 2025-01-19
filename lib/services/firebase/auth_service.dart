import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool login_sucess = true;
  bool register_sucess = true;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      login_sucess = true;
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      login_sucess = false;
      notifyListeners();
      throw Exception(e.message);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      register_sucess = true;
      await FirebaseFirestore.instance.collection('users').add({
        'user': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      register_sucess = false;
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
    return await _firebaseAuth.signOut();
  }

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser!.email;
  }
}
