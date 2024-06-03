import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import 'firebase_database_provider.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabaseProvider _databaseProvider = FirebaseDatabaseProvider();

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

  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final UserModel newUser = UserModel(
          userID: user.uid,
          userName: user.email!.split('@').first,
          email: user.email ?? '',
          name: user.displayName ?? 'New Account',
        );
        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        }else{
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    return currentUser;
  }
}
