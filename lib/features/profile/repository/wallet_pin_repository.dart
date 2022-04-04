import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/api.dart';
import '../../../cores/constants/http_helper.dart';

class WalletPinRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createWalletPin(String pin) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    await HttpHelper.post(
      uri: ApiEndpoints.createWalletPin,
      body: <String, dynamic>{'pin': pin, 'userId': userId},
    );
  }

  Future<void> updateWalletPin(String oldPin, String newPin) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    await HttpHelper.post(
      uri: ApiEndpoints.updateWalletPin,
      body: <String, dynamic>{
        'oldPin': oldPin,
        'newPin': newPin,
        'userId': userId,
      },
    );
  }
}
