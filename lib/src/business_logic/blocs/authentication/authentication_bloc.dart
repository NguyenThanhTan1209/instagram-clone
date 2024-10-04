import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
          emit(
            AuthenticationFailed(
              error: 'Sign in with facebook failed. Try again.',
            ),
          );
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignInWithGoogle>((
      SignInWithGoogle event,
      Emitter<AuthenticationState> emit,
    ) async {
      emit(AuthenticationInProgress());
      try {
        final UserModel? user = await _repository.signInWithGoogle();
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(
            AuthenticationFailed(
              error: 'Sign in with google failed. Try again.',
            ),
          );
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

    on<VerifyWithPhoneNumber>(
        (VerifyWithPhoneNumber event, Emitter<AuthenticationState> emit) async {
      emit(AuthenticationInProgress());
      try {
        final String result = await _repository.verifyPhoneNumber(phoneNumber: event.phoneNumber);
        if(result.isNotEmpty){
          emit(VerifyPhoneNumberSucess(verificationId: result));
        }else if(result.contains('error')){
          emit(AuthenticationFailed(error: 'Sign up failed'));
        }else{
          emit(AuthenticationInProgress());
        }
      } on FirebaseAuthException catch (e) {
        log(e.message!);
        emit(AuthenticationFailed(error: e.message!));
      }
    });

    on<SignUpWithPhoneNumber>(
        (SignUpWithPhoneNumber event, Emitter<AuthenticationState> emit) async {
      emit(AuthenticationInProgress());
      try {
        final UserModel? user = await _repository.signUpWithPhoneNumber(
          otpCode: event.otpCode,
          verificationId: event.verificationId,
        );
        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailed(error: 'Sign up failed'));
        }
      } catch (e) {
        log(e.toString());
        emit(AuthenticationFailed(error: 'Sign up failed'));
      }
    });
  }

  final AuthenticationRepository _repository = AuthenticationRepository();
}
