import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squid/data/repositories/auth_repository.dart';
import 'package:squid/ui/utils/dependencies.dart';
import 'package:squid/ui/utils/mocks/instances.dart';
import 'package:squid/ui/utils/mocks/mock_google_sign_in.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthRepository repository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth(mockUser: Mocks.user);
    mockGoogleSignIn = MockGoogleSignIn();

    Dependencies().configure(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
    repository = AuthRepository();
  });

  test('silent sign in succeeds when logged in', () async {
    mockFirebaseAuth = MockFirebaseAuth(mockUser: Mocks.user, signedIn: true);

    Dependencies().configure(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
    repository = AuthRepository();

    User? user = await repository.signInSilently();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('silent sign in succeeds when google logged in', () async {
    await mockGoogleSignIn.signIn();

    User? user = await repository.signInSilently();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('silent sign in fails when not signed in', () async {
    User? user = await repository.signInSilently();
    expect(user == null, isTrue);
  });

  test('sign in returns the correct user', () async {
    User? user = await repository.emailSignIn(email: 'test', password: 'test');
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('google sign in returns the correct user', () async {
    User? user = await repository.googleSignIn();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('email sign up returns the signed up user', () async {
    User? user = await repository.emailSignUp(email: 'test', password: 'test');
    expect(user != null, isTrue);
    expect(user?.displayName == 'Mock User', isTrue);
  });

  test('sign out logs out user', () async {
    mockFirebaseAuth = MockFirebaseAuth(mockUser: Mocks.user, signedIn: true);

    Dependencies().configure(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
    repository = AuthRepository();

    await repository.signOut();
    expect(mockFirebaseAuth.currentUser == null, isTrue);
  });
}
