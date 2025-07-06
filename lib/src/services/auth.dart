import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_generator_mobile/src/utils/constant.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return signupsuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message; // Generic error message
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return resetsuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      }
      return "An error occurred: ${e.message}";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }


  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return signinsuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message; // Generic error message
    } catch (e) {
      return e.toString();
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}