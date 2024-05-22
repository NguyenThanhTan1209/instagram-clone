import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirebaseDatabaseProvider {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<int> createUser(UserModel userModel) async {
    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection('users').doc();

    final UserModel user = UserModel(
      userID: userDoc.id,
      userName: userModel.userName,
      name: userModel.name,
      website: userModel.website,
      bio: userModel.bio,
      email: userModel.email,
      phone: userModel.phone,
      gender: userModel.gender,
    );

    final Map<String, dynamic> json = user.toJson();

    try {
      await userDoc.set(json);
      return 1;
    } on Exception catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
