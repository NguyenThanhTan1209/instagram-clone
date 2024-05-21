import 'package:firebase_auth/firebase_auth.dart';

import '../models/result.dart';
import '../services/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider = AuthenticationProvider();

    Future<Result?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authenticationProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _authenticationProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
