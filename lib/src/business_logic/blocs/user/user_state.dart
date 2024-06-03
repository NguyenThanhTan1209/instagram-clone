import '../../models/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  UserSuccessState({required this.user});

  final UserModel user;
}

class UserFailedState extends UserState {
  UserFailedState({required this.error});

  final String error;
}
