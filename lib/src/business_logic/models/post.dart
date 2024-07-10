import 'package:firebase_auth/firebase_auth.dart';

import 'comment.dart';

class Post {
  Post({
    required this.postID,
    required this.userID,
    required this.userName,
    required this.images,
    this.likedUsers = const <User>[],
    this.comments = const <PostComment>[],
    this.content = '',
    this.location = '',
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'postID': postID,
        'userID': userID,
        'userName': userName,
        'images': images,
        'likedUsers': likedUsers,
        'comments': comments,
        'content': content,
        'location': location,
      };

  String postID;
  String userID;
  String userName;
  List<String> images;
  List<User> likedUsers;
  List<PostComment> comments;
  String content;
  String location;
}
