import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/data/repositories/auth_repository.dart';
import 'package:squid/errors/squid_error.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthUnauthenticatedState()) {
    on<EmailSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await _authRepository.emailSignUp(email: event.email, password: event.password);
        emit(AuthAuthenticatedState());
      } on SquidError catch (e) {
        emit(AuthErrorState(e));
        emit(AuthUnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(SquidError.unknown(code: 'auth-bloc', message: e.toString())));
        emit(AuthUnauthenticatedState());
      }
    });

    on<EmailSignInEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await _authRepository.emailSignIn(email: event.email, password: event.password);
        emit(AuthAuthenticatedState());
      } on SquidError catch (e) {
        emit(AuthErrorState(e));
        emit(AuthUnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(SquidError.unknown(code: 'auth-bloc', message: e.toString())));
        emit(AuthUnauthenticatedState());
      }
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await _authRepository.googleSignIn();
        emit(AuthAuthenticatedState());
      } on SquidError catch (e) {
        emit(AuthErrorState(e));
        emit(AuthUnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(SquidError.unknown(code: 'auth-bloc', message: e.toString())));
        emit(AuthUnauthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await _authRepository.signOut();
        emit(AuthUnauthenticatedState());
      } on SquidError catch (e) {
        emit(AuthErrorState(e));
        emit(AuthUnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(SquidError.unknown(code: 'auth-bloc', message: e.toString())));
        emit(AuthUnauthenticatedState());
      }
    });
  }
}
