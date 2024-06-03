import '../../models/user.dart';

abstract class AuthenticationState{}

class AuthenticationInitial extends AuthenticationState {
  
}

class AuthenticationInProgress extends AuthenticationState {
  
}

class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({required this.user});

  final UserModel user;
}

class AuthenticationFailed extends AuthenticationState {
  AuthenticationFailed({required this.error});

  final String error;
}
