import 'package:flutter/foundation.dart';
import 'package:squid/errors/squid_error.dart';

@immutable
abstract class AuthEvent {}

@immutable
class AuthSilentSignInEvent extends AuthEvent {}

@immutable
class AuthEmailSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthEmailSignUpEvent(this.email, this.password);
}

@immutable
class AuthEmailSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthEmailSignInEvent(this.email, this.password);
}

@immutable
class AuthGoogleSignInEvent extends AuthEvent {}

@immutable
class AuthSignOutEvent extends AuthEvent {}

@immutable
class AuthErrorEvent extends AuthEvent {
  final SquidError error;

  AuthErrorEvent(this.error);
}
