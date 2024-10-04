import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import 'firebase_database_provider.dart';

const int CODE_SEND_TIME = 3;

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
        final UserModel signInUser = UserModel.instance;
        signInUser.userID = user.uid;
        signInUser.userName = user.email ?? '';
        signInUser.password = user.displayName ?? '';
        return signInUser;
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
        final UserModel newUser = UserModel.instance;
        newUser.userID = user.uid;
        newUser.userName = user.email!.split('@').first;
        newUser.email = user.email ?? '';
        newUser.name = user.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
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

  Future<UserModel?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);

      log(userCredential.toString());
      final User? user = userCredential.user;
      if (user != null) {
        final UserModel newUser = UserModel.instance;
        newUser.userID = user.uid;
        newUser.userName = user.email!.split('@').first;
        newUser.email = user.email ?? '';
        newUser.name = user.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the sign-in flow
      final GoogleSignInAccount? loginResult = await GoogleSignIn().signIn();

      // Create a credential from the access token
      final GoogleSignInAuthentication googleSignInAuthentication =
          await loginResult!.authentication;

      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(googleAuthCredential);

      log(userCredential.toString());
      final User? user = userCredential.user;
      if (user != null) {
        final UserModel newUser = UserModel.instance;
        newUser.userID = user.uid;
        newUser.userName = user.email!.split('@').first;
        newUser.email = user.email ?? '';
        newUser.name = user.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String> verifyPhoneNumber({required String phoneNumber}) async {
    String verificationID = '';
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          log(phoneAuthCredential.toString());
        },
        verificationFailed: (FirebaseAuthException error) async {
          log(error.message!);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('codeAutoRetrievalTimeout: $verificationId');
        },
      );
      while (verificationID.isEmpty) {
        await Future<void>.delayed(const Duration(seconds: CODE_SEND_TIME));
      }
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return 'error';
    }
    return verificationID;
  }

  Future<UserModel?> signUpWithPhoneNumber({
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      final PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(phoneCredential);
      log(userCredential.toString());
      final User? user = userCredential.user;
      if (user != null) {
        final UserModel newUser = UserModel.instance;
        newUser.userID = user.uid;
        newUser.userName = 'user_${user.phoneNumber!.split('+84').last}';
        newUser.phone = '0${user.phoneNumber!.split('+84').last}';
        newUser.email = user.email ?? '';
        newUser.name = user.displayName ?? 'New Account';
        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return null;
    }
  }
}
