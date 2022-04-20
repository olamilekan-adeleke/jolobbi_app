import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/api.dart';
import '../../../cores/constants/firebase_collection_key.dart';
import '../../../cores/constants/http_helper.dart';

class WalletRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final CollectionReference _walletCollectionRef =
      FirebaseFirestore.instance.collection(WALLET_REF);

  static final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);

  Future<Map<String, dynamic>> getWalletBalance() async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    final DocumentSnapshot documentSnapshot =
        await _walletCollectionRef.doc(userId).get();

    if (documentSnapshot.data() == null) {
      throw 'No Wallet was found for this user!';
    }

    return Map<String, dynamic>.from(documentSnapshot.data() as Map);
  }

  Future<void> verifyTransaction(int transactionRef) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    await HttpHelper.post(
      uri: ApiEndpoints.verifyTrans,
      body: <String, dynamic>{'tx_ref': transactionRef, 'userId': userId},
    );
  }

  Future<void> transferByBusinessTag(Map<String, dynamic> data) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    await HttpHelper.post(
      uri: ApiEndpoints.transferToVendor,
      body: <String, dynamic>{...data, 'userId': userId},
    );
  }

  Future<List<Map<String, dynamic>>> getUserTransactionHistory({
    int limit = 10,
    Timestamp? timestamp,
  }) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw 'Error: User not login';

    Query<Map<String, dynamic>> query = _userCollectionRef
        .doc(userId)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (timestamp != null) {
      query = query.startAfter([timestamp]);
    }

    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    final List<QueryDocumentSnapshot> queryDocumentSnapshot =
        querySnapshot.docs;

    final List<Map<String, dynamic>> result = queryDocumentSnapshot
        .map((ele) => ele.data() as Map<String, dynamic>)
        .toList();

    return result;
  }
}
