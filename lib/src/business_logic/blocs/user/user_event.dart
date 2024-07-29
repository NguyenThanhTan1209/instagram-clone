import 'package:file_picker/file_picker.dart';

abstract class UserEvent {}

class GetUserByID extends UserEvent {
  GetUserByID({required this.userID});

  final String userID;
}

class UpdateUserInformation extends UserEvent {
  UpdateUserInformation({required this.avatarPicker, required this.updateUser});

  final Map<String, String> updateUser;
  final PlatformFile? avatarPicker;
}
