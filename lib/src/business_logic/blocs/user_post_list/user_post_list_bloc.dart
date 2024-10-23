import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post.dart';
import '../../repository/post_repository.dart';
import 'user_post_list_event.dart';
import 'user_post_list_state.dart';

class UserPostListBloc extends Bloc<UserPostListEvent, UserPostListState> {
  UserPostListBloc() : super(UserPostListInitial()) {
    on<GetPostListByUserID>(
        (GetPostListByUserID event, Emitter<UserPostListState> emit) async {
      emit(UserPostListInProgress());
      try {
        final List<Post> result = await _repository.readPostListByUserId(userID: event.userID);
        emit(UserPostListSuccess(postList: result));
      } catch (e) {
        log(e.toString());
        emit(UserPostListFailed(error: e.toString()));
      }
    });
  }

  final PostRepository _repository = PostRepository();
}
