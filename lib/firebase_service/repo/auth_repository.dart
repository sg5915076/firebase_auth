import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Sign up a new user
  Future<String> signup(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid; // Return the user ID
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An error occurred during signup');
    }
  }

  /// Log in an existing user
  Future<String> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid; // Return the user ID
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An error occurred during login');
    }
  }

  /// Log out the current user
  Future<void> logout() async {
    print('Performing logout in repository'); // Debugging
    await FirebaseAuth.instance.signOut(); // Or your custom logout logic
    print('Firebase logout complete'); // Debugging
  }

}
