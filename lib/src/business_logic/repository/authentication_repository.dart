import '../models/user.dart';
import '../services/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider();

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

  Future<UserModel?> signInWithFacebook() async {
    return _authenticationProvider.signInWithFacebook();
  }

  Future<UserModel?> signInWithGoogle() async {
    return _authenticationProvider.signInWithGoogle();
  }

  Future<String> verifyPhoneNumber({required String phoneNumber}) async {
    return _authenticationProvider.verifyPhoneNumber(phoneNumber: phoneNumber);
  }

  Future<UserModel?> signUpWithPhoneNumber({
    required String verificationId,
    required String otpCode,
  }) async {
    return _authenticationProvider.signUpWithPhoneNumber(
      verificationId: verificationId,
      otpCode: otpCode,
    );
  }
}
