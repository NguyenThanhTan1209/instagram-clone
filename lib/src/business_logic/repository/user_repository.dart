import 'package:file_picker/file_picker.dart';

import '../models/user.dart';
import '../services/firebase_database_provider.dart';

class UserRepository {
  final FirebaseDatabaseProvider _firebaseDatabaseProvider = FirebaseDatabaseProvider();

  Future<int> createUser(UserModel user) async {
    return _firebaseDatabaseProvider.createUser(user);
  }

  Future<UserModel?> readUserByID(String userID){
    return _firebaseDatabaseProvider.readUserByID(userID);
  }

  Future<int> updateUser(Map<String,String> updatedData, PlatformFile? avatarFile) async {
    return _firebaseDatabaseProvider.updateUser(updatedData, avatarFile);
  }
}
