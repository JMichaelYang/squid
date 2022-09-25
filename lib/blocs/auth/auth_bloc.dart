import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/auth/auth_event.dart';
import 'package:squid/blocs/auth/auth_state.dart';
import 'package:squid/data/repositories/auth_repository.dart';
import 'package:squid/errors/squid_error.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthLoadingState()) {
    on<AuthSilentSignInEvent>(((event, emit) async {
      emit(AuthLoadingState());

      try {
        bool success = await _authRepository.signInSilently();
        emit(success ? AuthAuthenticatedState() : AuthUnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(SquidError.unknown(code: 'auth-bloc', message: e.toString())));
        emit(AuthUnauthenticatedState());
      }
    }));

    on<AuthEmailSignUpEvent>((event, emit) async {
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

    on<AuthEmailSignInEvent>((event, emit) async {
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

    on<AuthGoogleSignInEvent>((event, emit) async {
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

    on<AuthSignOutEvent>((event, emit) async {
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

    on<AuthErrorEvent>((event, emit) async {
      emit(AuthErrorState(event.error));
      emit(AuthUnauthenticatedState());
    });
  }
}
