import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:squid/errors/squid_error.dart';

abstract class AuthState extends Equatable {}

@immutable
class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

@immutable
class AuthAuthenticatedState extends AuthState {
  final User user;

  AuthAuthenticatedState(this.user);

  @override
  List<Object?> get props => [user];
}

@immutable
class AuthUnauthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

@immutable
class AuthErrorState extends AuthState {
  final SquidError error;

  AuthErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
