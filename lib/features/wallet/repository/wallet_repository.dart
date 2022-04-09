import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class WalletRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final CollectionReference walletCollectionRef =
      FirebaseFirestore.instance.collection(WALLET_REF);

  Future<Map<String, dynamic>> getWalletBalance() async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    final DocumentSnapshot documentSnapshot =
        await walletCollectionRef.doc(userId).get();

    if (documentSnapshot.data() == null) {
      throw 'No Wallet was found for this user!';
    }

    return Map<String, dynamic>.from(documentSnapshot.data() as Map);
  }

  






}
