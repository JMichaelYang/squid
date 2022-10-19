import 'package:squid/errors/squid_error.dart';

class AuthError extends SquidError {
  // Email and password sign up errors.
  static const SquidError weakPassword = AuthError(errorCode: 'weak-password');
  static const SquidError emailAlreadyInUse = AuthError(errorCode: 'email-already-in-use');
  static const SquidError notMatchingPassword = AuthError(errorCode: 'not-matching-password');
  static const SquidError signUp = AuthError(errorCode: 'sign-up');

  // Email and password sign in errors.
  static const SquidError userNotFound = AuthError(errorCode: 'user-not-found');
  static const SquidError wrongPassword = AuthError(errorCode: 'wrong-password');
  static const SquidError signIn = AuthError(errorCode: 'sign-in');

  // Sign out errors.
  static const SquidError signOut = AuthError(errorCode: 'sign-out');

  const AuthError({required super.errorCode, super.message}) : super(namespace: ErrorNamespace.auth);
}
