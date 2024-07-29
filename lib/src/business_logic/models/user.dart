import 'post.dart';
import 'story_album.dart';

class UserModel {

  UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) {
      final UserModel user = UserModel.instance;
      user.userID = json['userID'] as String;
      user.userName= json['userName'] as String;
      user.name= json['name'] as String;
      user.website= json['website'] as String;
      user.bio= json['bio'] as String;
      user.email= json['email'] as String;
      user.phone= json['phone'] as String;
      user.gender= json['gender'] as String;
      user.avatarPath=  json['avatarPath'] as String;
    return user;
  }
  
  static UserModel? _INSTANCE;

  static UserModel get instance {
    _INSTANCE ??= UserModel._();
    return _INSTANCE!;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userID': userID,
        'userName': userName,
        'name': name,
        'website': website,
        'bio': bio,
        'email': email,
        'phone': phone,
        'gender': gender,
        'avatarPath' : avatarPath,
      };

  String userID = '';
  String userName = '';
  String password = '';
  String avatarPath = '';
  String name = '';
  int postTotal = 0;
  int followerTotal= 0;
  int followingTotal = 0;
  String description = '';
  String website = '';
  String bio = '';
  String email = '';
  String phone = '';
  String gender = '';
  List<Post> posts = <Post>[];
  List<StoryAlbum> storieAlbums = <StoryAlbum>[];
}
