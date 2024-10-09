import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      // Assuming you're using FirebaseAuth
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Optionally, check if the user is null
      if (userCredential.user == null) {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to sign in: Incorrect Email or Password');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}



