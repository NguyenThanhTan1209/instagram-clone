import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post.dart';
import '../../repository/post_repository.dart';
import 'post_list_event.dart';
import 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {

  PostListBloc() : super(PostListInitial()) {
    on<GetPostList>(
      (GetPostList event, Emitter<PostListState> emit) async {
        emit(PostListInProgress());
        try {
          final List<Post> result = await repository.readPostList();
          if (result.isNotEmpty) {
            emit(PostListSuccess(postList: result));
          } else {
            emit(PostListFailed(error: 'Load list failed'));
          }
        } catch (e) {
          log(e.toString());
          emit(PostListFailed(error: 'Something failed'));
        }
      },
    );
  }
  PostRepository repository = PostRepository();
}
