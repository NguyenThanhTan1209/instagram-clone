import '../models/user.dart';
import '../services/firebase_database_provider.dart';

class UserRepository {
  final FirebaseDatabaseProvider _firebaseDatabaseProvider = FirebaseDatabaseProvider();

  Future<int> createUser(UserModel user) async {
    return _firebaseDatabaseProvider.createUser(user);
  }
}
