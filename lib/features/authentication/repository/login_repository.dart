import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class LoginRepository {
  final LocalAuthentication localAuth = LocalAuthentication();
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

  Future<bool> useBiometricLogin() async {
    try {
      if (await checkBiometric() == false) {
        throw 'Opps, Can Not Use Biometric Login!';
      }

      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        biometricOnly: true,
      );

      return didAuthenticate;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> checkBiometric() async => await localAuth.canCheckBiometrics;
}
