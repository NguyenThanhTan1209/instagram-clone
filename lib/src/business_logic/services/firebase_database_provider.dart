import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../views/utils/path_constant.dart';
import '../models/post.dart';
import '../models/user.dart';

const String USERS_COLLECTION = 'users';
const String POSTS_COLLECTION = 'posts';

class FirebaseDatabaseProvider {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late UploadTask? _avatarUploadTask;

  // User Handle
  Future<int> createUser(UserModel userModel) async {
    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection(USERS_COLLECTION).doc(userModel.userID);

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
    }
    return 0;
  }

  Future<UserModel?> readUserByID(String userID) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> userDoc =
        _database.collection(USERS_COLLECTION).doc(userID).get();

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

  Future<int> updateUser(
    Map<String, String> updatedData,
    File? avatarFile,
  ) async {
    if (avatarFile != null) {
      final String avatarPath =
          '${PathConstant.FIREBASE_USER_STORAGE_PATH}/${updatedData['userID']}/avatar/${DateTime.now().millisecondsSinceEpoch}/$avatarFile';
      final File file = File(avatarFile.path);

      final Reference ref = _storage.ref().child(avatarPath);
      _avatarUploadTask = ref.putFile(file);

      await _avatarUploadTask!.whenComplete(() async {
        updatedData['avatarPath'] =
            await _avatarUploadTask!.snapshot.ref.getDownloadURL();
      });
    }

    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection(USERS_COLLECTION).doc(updatedData['userID']);

    try {
      await userDoc.update(updatedData);
      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  //Handle Post
  Future<int> createPost(Post post) async {
    final File file = File(post.media.first);
    final String postPath =
        '${PathConstant.FIREBASE_POST_STORAGE_PATH}/${post.userID}/${post.postID}/${DateTime.now().millisecondsSinceEpoch}/${post.media.first.split("/").last}';

    final Reference ref = _storage.ref().child(postPath);
    _avatarUploadTask = ref.putFile(file);

    await _avatarUploadTask!.whenComplete(() async {
      post.media.first = await _avatarUploadTask!.snapshot.ref.getDownloadURL();
    });

    final DocumentReference<Map<String, dynamic>> postDoc =
        _database.collection(POSTS_COLLECTION).doc(post.postID);
    final DocumentReference<Map<String, dynamic>> userDoc =
        _database.collection(USERS_COLLECTION).doc(post.userID);

    final Post createPost = Post(
      postID: const Uuid().v1(),
      userID: post.userID,
      userName: post.userName,
      avatarPath: post.avatarPath,
      media: post.media,
      content: post.content,
      likedUsers: post.likedUsers,
      comments: post.comments,
      location: post.location,
      createdDate: post.createdDate,
    );

    final Map<String, dynamic> json = createPost.toJson();

    try {
      await postDoc.set(json);
      await userDoc.set(<String, List<String>>{
        'posts': <String>[
          post.postID,
        ],
      });
      return 1;
    } on Exception catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<List<Post>> readPostList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> postDoc = await _database
          .collection(POSTS_COLLECTION)
          .orderBy('createdDate', descending: true)
          .get();
      final List<Map<String, dynamic>> postList = postDoc.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data())
          .toList();

      return postList
          .map((Map<String, dynamic> e) => Post.fromJson(e))
          .toList();
    } catch (e) {
      log(e.toString());
      return <Post>[];
    }
  }

  Future<List<Post>> readPostListByUserId({required String userID}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> postDoc = await _database
          .collection(POSTS_COLLECTION)
          .where('userID', isEqualTo: userID)
          .orderBy('createdDate', descending: true)
          .get();
      final List<Map<String, dynamic>> postList = postDoc.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data())
          .toList();

      return postList
          .map((Map<String, dynamic> e) => Post.fromJson(e))
          .toList();
    } catch (e) {
      log(e.toString());
      return <Post>[];
    }
  }
}
