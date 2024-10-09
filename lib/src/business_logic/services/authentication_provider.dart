import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import 'firebase_database_provider.dart';

const int CODE_SEND_TIME = 2;

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
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        final User signUpUnser = userCredential.user!;
        final UserModel newUser = UserModel.instance;
        newUser.userID = signUpUnser.uid;
        newUser.userName = signUpUnser.email!.split('@').first;
        newUser.email = signUpUnser.email ?? '';
        newUser.name = signUpUnser.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        final UserModel? user =
            await _databaseProvider.readUserByID(userCredential.user!.uid);
        if (user != null) {
          return user;
        }
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

      if (userCredential.user != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        final User signUpUser = userCredential.user!;
        final UserModel newUser = UserModel.instance;
        newUser.userID = signUpUser.uid;
        newUser.userName = signUpUser.email!.split('@').first;
        newUser.email = signUpUser.email ?? '';
        newUser.name = signUpUser.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        }
      } else {
        final UserModel? user =
            await _databaseProvider.readUserByID(userCredential.user!.uid);
        if (user != null) {
          return user;
        }
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

      if (userCredential.user != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        final User signUpUnser = userCredential.user!;
        final UserModel newUser = UserModel.instance;
        newUser.userID = signUpUnser.uid;
        newUser.userName = signUpUnser.email!.split('@').first;
        newUser.email = signUpUnser.email ?? '';
        newUser.name = signUpUnser.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        final UserModel? user =
            await _databaseProvider.readUserByID(userCredential.user!.uid);
        if (user != null) {
          return user;
        }
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
          log('verificationCompleted: $phoneAuthCredential');
        },
        verificationFailed: (FirebaseAuthException error) async {
          log('verificationFailed: ${error.message}');
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

      if (userCredential.user != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        final User signUpUnser = userCredential.user!;
        final UserModel newUser = UserModel.instance;
        newUser.userID = signUpUnser.uid;
        newUser.userName = 'user_${signUpUnser.phoneNumber!.split('+84').last}';
        newUser.phone = '0${signUpUnser.phoneNumber!.split('+84').last}';
        newUser.email = signUpUnser.email ?? '';
        newUser.name = signUpUnser.displayName ?? 'New Account';

        final int result = await _databaseProvider.createUser(newUser);
        if (result == 1) {
          return newUser;
        } else {
          return null;
        }
      } else {
        final UserModel? user =
            await _databaseProvider.readUserByID(userCredential.user!.uid);
        if (user != null) {
          return user;
        }
      }
    } on FirebaseAuthException catch (e) {
      log(e.message!);
    }
    return null;
  }
}
