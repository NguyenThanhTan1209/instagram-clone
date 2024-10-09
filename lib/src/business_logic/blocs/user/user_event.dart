import 'dart:io';

abstract class UserEvent {}

class GetUserByID extends UserEvent {
  GetUserByID({required this.userID});

  final String userID;
}

class UpdateUserInformation extends UserEvent {
  UpdateUserInformation({required this.avatarPicker, required this.updateUser});

  final Map<String, String> updateUser;
  final File? avatarPicker;
}
