import '../../models/user.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({required this.user});

  final UserModel user;
}

class VerifyPhoneNumberSucess extends AuthenticationState {
  VerifyPhoneNumberSucess({required this.verificationId});

  final String verificationId;
}

class AuthenticationFailed extends AuthenticationState {
  AuthenticationFailed({required this.error});

  final String error;
}
