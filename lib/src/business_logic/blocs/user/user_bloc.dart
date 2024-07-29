import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserByID>((GetUserByID event, Emitter<UserState> emit) async {
      emit(UserLoadingState());
      try {
        final UserModel? result =
            await _userRepository.readUserByID(event.userID);
        if (result != null) {
          emit(UserSuccessState(user: result));
        } else {
          emit(UserFailedState(error: 'User information not found'));
        }
      } catch (e) {
        log(e.toString());
        emit(UserFailedState(error: 'An error occurred, please try again'));
      }
    });
    on<UpdateUserInformation>(
        (UpdateUserInformation event, Emitter<UserState> emit) async {
      emit(UserLoadingState());
      try {
        final int result = await _userRepository.updateUser(
          event.updateUser,
          event.avatarPicker,
        );
        if (result == 1) {
          final UserModel? result =
              await _userRepository.readUserByID(event.updateUser['userID']!);
          if (result != null) {
            emit(UserSuccessState(user: UserModel.instance));
          }else{
            emit(UserFailedState(error: 'Not find account'));
          }
        } else {
          emit(UserFailedState(error: 'Update Failed'));
        }
      } catch (e) {
        log(e.toString());
        emit(UserFailedState(error: 'The update process was interrupted: $e'));
      }
    });
  }

  final UserRepository _userRepository = UserRepository();
}
