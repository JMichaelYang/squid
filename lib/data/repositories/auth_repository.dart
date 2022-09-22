import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:squid/errors/auth_errors.dart';
import 'package:squid/errors/squid_error.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

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
      throw SquidError.unknown(message: e.toString());
    }
  }

  Future signIn({required String email, required String password}) async {
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
      throw SquidError.unknown(message: e.toString());
    }
  }

  Future googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw SquidError.unknown(message: e.toString());
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
