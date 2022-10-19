import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:squid/errors/auth_error.dart';
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
          throw AuthError.weakPassword;
        case 'email-already-in-use':
          throw AuthError.emailAlreadyInUse;
        default:
          throw AuthError.signUp;
      }
    } catch (e) {
      throw AuthError(errorCode: 'email-sign-up', message: e.toString());
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
          throw AuthError.userNotFound;
        case 'wrong-password':
          throw AuthError.wrongPassword;
        default:
          throw AuthError.signIn;
      }
    } catch (e) {
      throw AuthError(errorCode: 'email-sign-in', message: e.toString());
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
      throw AuthError(errorCode: 'google-sign-in', message: e.toString());
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthError.signOut;
    }
  }
}
