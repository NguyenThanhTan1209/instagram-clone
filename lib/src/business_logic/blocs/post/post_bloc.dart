import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostBloc():super(PostInitial()){
    on<CreatePost>((CreatePost event, Emitter<PostState> emit) async {
      emit(PostInProgress());
      try {
        final int result = await _repository.createPost(event.post);
        if (result != 0) {
          emit(PostSuccess(post: event.post));
        }else{
          emit(PostFailed(error: 'Add Post Failed'));
        }
      } catch (e) {
        log(e.toString());
        emit(PostFailed(error: 'Something wrong'));
      }
    });
  }
  final PostRepository _repository = PostRepository();
}