enum AuthenticationEnum{PASS, FAILED}

abstract class AuthenticationEvent{}

class SignUpWithEmailAndPassword extends AuthenticationEvent {
  
}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  SignInWithEmailAndPassword({required this.username, required this.password});

  final String username;
  final String password;
}
