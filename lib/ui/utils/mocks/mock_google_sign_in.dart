import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {
  MockGoogleSignInAccount? _currentUser;

  bool _isCancelled = false;

  Exception? _exception;
  set exception(Exception? exception) => _exception = exception;

  set isCancelled(bool val) {
    _isCancelled = val;
  }

  void resetException() {
    _exception = null;
  }

  @override
  GoogleSignInAccount? get currentUser => _currentUser;

  @override
  Future<GoogleSignInAccount?> signIn() {
    if (_exception != null) throw _exception!;

    _currentUser = MockGoogleSignInAccount();
    return Future.value(_isCancelled ? null : _currentUser);
  }

  @override
  Future<GoogleSignInAccount?> signInSilently({bool reAuthenticate = false, bool suppressErrors = false}) {
    if (_exception != null) throw _exception!;

    if (currentUser == null) return Future.value(null);
    return Future.value(_isCancelled ? null : _currentUser);
  }
}

// ignore: must_be_immutable
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {
  @override
  Future<GoogleSignInAuthentication> get authentication => Future.value(MockGoogleSignInAuthentication());
}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {
  @override
  String get idToken => 'idToken';

  @override
  String get accessToken => 'accessToken';
}
