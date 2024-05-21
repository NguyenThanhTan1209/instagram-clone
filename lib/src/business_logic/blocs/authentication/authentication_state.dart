import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState{}

class AuthenticationInitial extends AuthenticationState {
  
}

class AuthenticationInProgress extends AuthenticationState {
  
}

class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({required this.user});

  final User user;
}

class AuthenticationFailed extends AuthenticationState {
  AuthenticationFailed({required this.error});

  final String error;
}
