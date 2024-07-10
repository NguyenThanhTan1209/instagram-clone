import '../../models/post.dart';

abstract class PostEvent {}

class CreatePost extends PostEvent {
  CreatePost({required this.post});

  final Post post;
}
