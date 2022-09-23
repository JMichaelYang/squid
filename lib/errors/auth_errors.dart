import 'package:squid/errors/squid_error.dart';

class AuthErrors {
  static const String namespace = 'auth';

  // Email and password sign up errors.
  static const SquidError weakPassword = SquidError(namespace: namespace, errorCode: 'weak-password');
  static const SquidError emailAlreadyInUse = SquidError(namespace: namespace, errorCode: 'email-already-in-use');
  static const SquidError notMatchingPassword = SquidError(namespace: namespace, errorCode: 'not-matching-password');
  static const SquidError signUp = SquidError(namespace: namespace, errorCode: 'sign-up');

  // Email and password sign in errors.
  static const SquidError userNotFound = SquidError(namespace: namespace, errorCode: 'user-not-found');
  static const SquidError wrongPassword = SquidError(namespace: namespace, errorCode: 'wrong-password');
  static const SquidError signIn = SquidError(namespace: namespace, errorCode: 'sign-in');

  // Sign out errors.
  static const SquidError signOut = SquidError(namespace: namespace, errorCode: 'sign-out');
}
