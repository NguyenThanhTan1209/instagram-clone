import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../views/utils/path_constant.dart';
import '../models/post.dart';
import '../models/user.dart';

class FirebaseDatabaseProvider {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late UploadTask? _avatarUploadTask;

  Future<int> createUser(UserModel userModel) async {
    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection('users').doc(userModel.userID);

    final UserModel user = UserModel.instance;
    user.userID = userDoc.id;
    user.userName = userModel.userName;
    user.name = userModel.name;
    user.website = userModel.website;
    user.bio = userModel.bio;
    user.email = userModel.email;
    user.phone = userModel.phone;
    user.gender = userModel.gender;

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
        user.avatarPath =
            await _avatarUploadTask!.snapshot.ref.getDownloadURL();
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

  Future<int> createPost(Post post) async {
    final File file = File(post.images.first);
    final String postPath =
        '${PathConstant.FIREBASE_POST_STORAGE_PATH}/${post.userID}/${post.postID}/${DateTime.now().millisecondsSinceEpoch}/${post.images.first.split("/").last}';
    

      final Reference ref = _storage.ref().child(postPath);
      _avatarUploadTask = ref.putFile(file);

      await _avatarUploadTask!.whenComplete(() async {
        post.images.first =
            await _avatarUploadTask!.snapshot.ref.getDownloadURL();
      });


    final DocumentReference<Map<String, dynamic>> postDoc =
        _database.collection('posts').doc(post.postID);

    final Post createPost = Post(
      postID: const Uuid().v1(),
      userID: post.userID,
      userName: post.userName,
      images: post.images,
      content: post.content,
    );

    final Map<String, dynamic> json = createPost.toJson();

    try {
      await postDoc.set(json);
      return 1;
    } on Exception catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
