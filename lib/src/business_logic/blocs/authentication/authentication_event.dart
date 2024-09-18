enum AuthenticationEnum { PASS, FAILED }

abstract class AuthenticationEvent {}

class SignUpWithEmailAndPassword extends AuthenticationEvent {
  SignUpWithEmailAndPassword({required this.username, required this.password});

  final String username;
  final String password;
}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  SignInWithEmailAndPassword({required this.username, required this.password});

  final String username;
  final String password;
}

class SignInWithFacebook extends AuthenticationEvent {}

class SignInWithGoogle extends AuthenticationEvent {}
