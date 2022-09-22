import 'package:squid/errors/squid_error.dart';

class AuthErrors {
  static const String namespace = 'auth';

  // Email and password sign up errors.
  static final SquidError weakPassword = SquidError(namespace: namespace, errorCode: 'weak-password');
  static final SquidError emailAlreadyInUse = SquidError(namespace: namespace, errorCode: 'email-already-in-use');
  static final SquidError signUp = SquidError(namespace: namespace, errorCode: 'sign-up');

  // Email and password sign in errors.
  static final SquidError userNotFound = SquidError(namespace: namespace, errorCode: 'user-not-found');
  static final SquidError wrongPassword = SquidError(namespace: namespace, errorCode: 'wrong-password');
  static final SquidError signIn = SquidError(namespace: namespace, errorCode: 'sign-in');

  // Sign out errors.
  static final SquidError signOut = SquidError(namespace: namespace, errorCode: 'sign-out');
}
