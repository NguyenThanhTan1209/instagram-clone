abstract class PostListEvent {}

class GetPostList extends PostListEvent {}

class GetPostListByUserID extends PostListEvent{
  GetPostListByUserID({required this.userID});

  final String userID;
}
