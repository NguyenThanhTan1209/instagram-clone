import '../../models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostInProgress extends PostState {}

class PostSuccess extends PostState {
  PostSuccess({required this.post});

  final Post post;
}

class PostFailed extends PostState {
  PostFailed({required this.error});

  final String error;
}
