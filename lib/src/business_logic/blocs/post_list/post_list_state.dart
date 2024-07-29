import '../../models/post.dart';

abstract class PostListState {}

class PostListInitial extends PostListState {}

class PostListInProgress extends PostListState {}

class PostListSuccess extends PostListState {
  PostListSuccess({required this.postList});

  final List<Post> postList;
}

class PostListFailed extends PostListState {
  PostListFailed({required this.error});

  final String error;
}
