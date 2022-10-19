import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squid/data/repositories/auth_repository.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';
import 'package:squid/ui/utils/mocks/instances.dart';
import 'package:squid/ui/utils/mocks/mock_google_sign_in.dart';

void main() {
  late AuthRepository repository;
  late MockFirebaseAuth auth;
  late MockGoogleSignIn google;

  setUp(() {
    auth = MockFirebaseAuth(mockUser: Mocks.user);
    google = MockGoogleSignIn();
    Dependencies().configureDefault(useMocks: true).configure(firebaseAuth: auth, googleSignIn: google);

    repository = AuthRepository();
  });

  tearDownAll(() {
    Dependencies().configure(firebaseAuth: auth, googleSignIn: google);
  });

  test('silent sign in succeeds when logged in', () async {
    FirebaseAuth mockAuth = MockFirebaseAuth(mockUser: Mocks.user, signedIn: true);

    Dependencies().configure(firebaseAuth: mockAuth);
    repository = AuthRepository();

    User? user = await repository.signInSilently();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('silent sign in succeeds when google logged in', () async {
    await google.signIn();

    User? user = await repository.signInSilently();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('silent sign in fails when not signed in', () async {
    User? user = await repository.signInSilently();
    expect(user == null, isTrue);
  });

  test('silent sign in fails silently on exceptions', () async {
    google.exception = Exception('silent sign in test');

    User? user = await repository.signInSilently();
    expect(user == null, isTrue);

    google.resetException();
  });

  test('email sign in returns the correct user', () async {
    User? user = await repository.emailSignIn(email: 'test', password: 'test');
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('email sign in handles exceptions', () async {
    FirebaseAuth mockAuth = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword: FirebaseAuthException(code: 'test-code'),
      ),
    );

    Dependencies().configure(firebaseAuth: mockAuth);
    repository = AuthRepository();

    await expectLater(repository.emailSignIn(email: 'test', password: 'test'), throwsA(isA<SquidError>()));
  });

  test('google sign in returns the correct user', () async {
    User? user = await repository.googleSignIn();
    expect(user != null, isTrue);
    expect(user?.displayName == 'Test Account', isTrue);
  });

  test('google sign in handles exceptions', () async {
    google.exception = Exception('silent sign in test');

    await expectLater(repository.googleSignIn(), throwsA(isA<SquidError>()));

    google.resetException();
  });

  test('email sign up returns the signed up user', () async {
    User? user = await repository.emailSignUp(email: 'test', password: 'test');
    expect(user != null, isTrue);
    expect(user?.displayName == 'Mock User', isTrue);
  });

  test('emaul sign up handles exceptions', () async {
    FirebaseAuth mockAuth = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        createUserWithEmailAndPassword: FirebaseAuthException(code: 'test-code'),
      ),
    );

    Dependencies().configure(firebaseAuth: mockAuth);
    repository = AuthRepository();

    await expectLater(repository.emailSignUp(email: 'test', password: 'test'), throwsA(isA<SquidError>()));
  });

  test('sign out logs out user', () async {
    FirebaseAuth mockAuth = MockFirebaseAuth(mockUser: Mocks.user, signedIn: true);

    Dependencies().configure(firebaseAuth: mockAuth);
    repository = AuthRepository();

    await repository.signOut();
    expect(mockAuth.currentUser == null, isTrue);
  });
}
