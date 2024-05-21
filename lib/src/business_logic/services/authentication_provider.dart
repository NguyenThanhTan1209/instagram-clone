import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/result.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<Result?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result(result: 'Pass', user: currentUser);
    } catch (e) {
      log(e.toString());
      return Result(result: e.toString().split(']').last, user: null);
    }
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
