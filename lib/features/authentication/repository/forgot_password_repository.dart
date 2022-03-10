import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
