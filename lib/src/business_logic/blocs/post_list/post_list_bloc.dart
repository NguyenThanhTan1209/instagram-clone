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
          final List<Post> result = await _repository.readPostList();
          emit(PostListSuccess(postList: result));
        } catch (e) {
          log(e.toString());
          emit(PostListFailed(error: 'Something failed'));
        }
      },
    );

    on<GetPostListByUserID>(
        (GetPostListByUserID event, Emitter<PostListState> emit) async {
      emit(PostListInProgress());
      try {
        final List<Post> result = await _repository.readPostListByUserId(userID: event.userID);
        emit(PostListSuccess(postList: result));
      } catch (e) {
        log(e.toString());
        emit(PostListFailed(error: e.toString()));
      }
    });
  }

  final PostRepository _repository = PostRepository();
}
