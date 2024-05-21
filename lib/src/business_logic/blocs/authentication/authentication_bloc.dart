import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/result.dart';
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
        final Result? result = await _repository.signInWithEmailAndPassword(
          email: event.username,
          password: event.password,
        );
        if(result!.result.contains('Pass')){
          emit(AuthenticationSuccess(user: result.user!));
        }else{
          emit(AuthenticationFailed(error: result.result));
        }
      } catch (e) {
        emit(AuthenticationFailed(error: e.toString()));
      }
    });
  }

  final AuthenticationRepository _repository = AuthenticationRepository();
}
