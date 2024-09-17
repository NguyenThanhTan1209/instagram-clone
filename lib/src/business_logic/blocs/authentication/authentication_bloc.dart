import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../repository/authentication_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignInWithEmailAndPassword>((
      SignInWithEmailAndPassword event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(AuthenticationInProgress());
      try {
        final UserModel? user = await _repository.signInWithEmailAndPassword(
          email: event.username,
          password: event.password,
        );
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailed(error: 'Username or Password incorrect'));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignInWithFacebook>((
      SignInWithFacebook event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(AuthenticationInProgress());
      try {
        final UserModel? user = await _repository.signInWithFacebook();
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailed(error: 'Username or Password incorrect'));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignUpWithEmailAndPassword>((
      SignUpWithEmailAndPassword event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(AuthenticationInProgress());
      try {
        final UserModel? user = await _repository.signUpWithEmailAndPassword(
          email: event.username,
          password: event.password,
        );
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailed(error: 'Sign up failed'));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }

  final AuthenticationRepository _repository = AuthenticationRepository();
}
