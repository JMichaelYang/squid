import 'package:flutter/cupertino.dart';

abstract class AuthEvent {}

@immutable
class EmailSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  EmailSignUpEvent(this.email, this.password);
}

@immutable
class EmailSignInEvent extends AuthEvent {
  final String email;
  final String password;

  EmailSignInEvent(this.email, this.password);
}

@immutable
class GoogleSignInEvent extends AuthEvent {}

@immutable
class SignOutEvent extends AuthEvent {}
