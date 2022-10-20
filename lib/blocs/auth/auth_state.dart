import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:squid/errors/squid_error.dart';

abstract class AuthState {}

@immutable
class AuthLoadingState extends AuthState {}

@immutable
class AuthAuthenticatedState extends AuthState {
  final User user;

  AuthAuthenticatedState(this.user);
}

@immutable
class AuthUnauthenticatedState extends AuthState {}

@immutable
class AuthErrorState extends AuthState {
  final SquidError error;

  AuthErrorState(this.error);
}
