abstract class UserPostListEvent {}

class GetPostListByUserID extends UserPostListEvent{
  GetPostListByUserID({required this.userID});

  final String userID;
}
