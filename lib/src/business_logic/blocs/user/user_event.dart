import '../../models/user.dart';

abstract class UserEvent {}

class GetUserByID extends UserEvent {
  GetUserByID({required this.userID});

  final String userID;
}

class UpdateUserInformation extends UserEvent {
  UpdateUserInformation({required this.updateUser});

  final UserModel updateUser;
}
