import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:squid/errors/auth_errors.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/ui/utils/constants.dart';
import 'package:squid/ui/utils/mocks.dart';

class AuthRepository {
  final _firebaseAuth = Constants.mockSignIn
      ? MockFirebaseAuth(
          mockUser: Mocks.user,
        )
      : FirebaseAuth.instance;

  Future<bool> signInSilently() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        return true;
      }

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future emailSignUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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

  Future emailSignIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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

  Future googleSignIn() async {
    try {
      GoogleSignIn signIn = Constants.mockSignIn ? MockGoogleSignIn() : GoogleSignIn();
      final GoogleSignInAccount? googleUser = await signIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
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
