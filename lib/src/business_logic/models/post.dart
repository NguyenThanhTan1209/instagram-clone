class Post {
  Post({
    required this.postID,
    required this.userID,
    required this.avatarPath,
    required this.userName,
    required this.images,
    required this.createdDate,
    required this.likedUsers,
    required this.comments,
    this.content = '',
    this.location = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postID: json['postID'] as String,
      userID: json['userID'] as String,
      userName: json['userName'] as String,
      avatarPath: json['avatarPath'] as String,
      images: List<String>.from(json['images'] as List<dynamic>),
      likedUsers: List<String>.from(json['likedUsers'] as List<dynamic>),
      comments: List<String>.from(json['comments'] as List<dynamic>),
      content: json['content'] as String,
      location: json['location'] as String,
      createdDate: json['createdDate'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'postID': postID,
        'userID': userID,
        'userName': userName,
        'images': images,
        'likedUsers': likedUsers,
        'comments': comments,
        'content': content,
        'location': location,
        'avatarPath': avatarPath,
        'createdDate': createdDate,
      };

  String postID;
  String userID;
  String userName;
  String avatarPath;
  List<String> images;
  List<String>? likedUsers;
  List<String>? comments;
  String content;
  String location;
  String createdDate;
}
