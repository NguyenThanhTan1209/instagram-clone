import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = credential.user;
      if (user != null) {
        return UserModel(
          userID: user.uid,
          userName: user.email ?? '',
          name: user.displayName ?? '',
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return currentUser;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    return currentUser;
  }
}
