import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:squid/errors/auth_errors.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository()
      : _firebaseAuth = Dependencies().firebaseAuth,
        _googleSignIn = Dependencies().googleSignIn;

  Future<User?> signInSilently() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        return _firebaseAuth.currentUser;
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential firebaseCredential = await _firebaseAuth.signInWithCredential(credential);
      return firebaseCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> emailSignUp({required String email, required String password}) async {
    try {
      UserCredential firebaseCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return firebaseCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw AuthErrors.weakPassword;
        case 'email-already-in-use':
          throw AuthErrors.emailAlreadyInUse;
        default:
          throw AuthErrors.signUp;
      }
    } catch (e) {
      throw SquidError.unknown(code: 'email-sign-up', message: e.toString());
    }
  }

  Future<User?> emailSignIn({required String email, required String password}) async {
    try {
      UserCredential firebaseCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return firebaseCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthErrors.userNotFound;
        case 'wrong-password':
          throw AuthErrors.wrongPassword;
        default:
          throw AuthErrors.signIn;
      }
    } catch (e) {
      throw SquidError.unknown(code: 'email-sign-in', message: e.toString());
    }
  }

  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential firebaseCredential = await _firebaseAuth.signInWithCredential(credential);
      return firebaseCredential.user;
    } catch (e) {
      throw SquidError.unknown(code: 'google-sign-in', message: e.toString());
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthErrors.signOut;
    }
  }
}
