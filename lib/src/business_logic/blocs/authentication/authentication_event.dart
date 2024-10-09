enum AuthenticationEnum { PASS, FAILED }

abstract class AuthenticationEvent {}

class SignUpWithEmailAndPassword extends AuthenticationEvent {
  SignUpWithEmailAndPassword({required this.email, required this.password});

  final String email;
  final String password;
}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  SignInWithEmailAndPassword({required this.email, required this.password});

  final String email;
  final String password;
}

class SignInWithFacebook extends AuthenticationEvent {}

class SignInWithGoogle extends AuthenticationEvent {}

class VerifyWithPhoneNumber extends AuthenticationEvent {
  VerifyWithPhoneNumber({required this.phoneNumber});

  final String phoneNumber;
}

class SignUpWithPhoneNumber extends AuthenticationEvent {
  SignUpWithPhoneNumber({required this.verificationId, required this.otpCode});

  final String verificationId;
  final String otpCode;
}
