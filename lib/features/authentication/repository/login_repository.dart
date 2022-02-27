import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
