import '../../models/post.dart';

abstract class UserPostListState {}

class UserPostListInitial extends UserPostListState {}

class UserPostListInProgress extends UserPostListState {}

class UserPostListSuccess extends UserPostListState {
  UserPostListSuccess({required this.postList});

  final List<Post> postList;
}

class UserPostListFailed extends UserPostListState {
  UserPostListFailed({required this.error});

  final String error;
}
