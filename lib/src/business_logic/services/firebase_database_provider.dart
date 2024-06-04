import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../views/utils/path_constant.dart';
import '../models/user.dart';

class FirebaseDatabaseProvider {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late UploadTask? _avatarUploadTask;

  Future<int> createUser(UserModel userModel) async {
    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection('users').doc(userModel.userID);

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

  Future<UserModel?> readUserByID(String userID) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> userDoc =
        _database.collection('users').doc(userID).get();

    return userDoc.then(
      (DocumentSnapshot<Map<String, dynamic>> value) {
        final Map<String, dynamic>? data = value.data();
        if (data != null) {
          return UserModel.fromJson(data);
        } else {
          return null;
        }
      },
    );
  }

  Future<int> updateUser(UserModel user, PlatformFile? avatarFile) async {
    if (avatarFile != null) {
      final String avatarPath =
          '${PathConstant.FIREBASE_USER_STORAGE_PATH}/${user.userID}/avatar/${DateTime.now().millisecondsSinceEpoch}/${avatarFile.name}';
      final File file = File(avatarFile.path!);

      final Reference ref = _storage.ref().child(avatarPath);
      _avatarUploadTask = ref.putFile(file);

      await _avatarUploadTask!.whenComplete(() async {
        user.avatarPath = await _avatarUploadTask!.snapshot.ref.getDownloadURL();
      });
    }

    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection('users').doc(user.userID);

    try {
      await userDoc.update(user.toJson());
      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
