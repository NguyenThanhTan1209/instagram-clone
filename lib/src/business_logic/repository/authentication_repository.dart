import '../models/user.dart';
import '../services/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider = AuthenticationProvider();

    Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authenticationProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _authenticationProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
