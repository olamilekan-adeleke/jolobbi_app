import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

import '../../../cores/constants/firebase_collection_key.dart';
import 'push_notification_repo.dart';

class LoginRepository {
  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);
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

  Future<void> updateUserFCM() async {
    final DocumentReference documentReference =
        userCollectionRef.doc(_firebaseAuth.currentUser!.uid);

    await documentReference.update({
      'fcm_token': await PushNotificationService().getFCMToken(),
    });
  }
}
