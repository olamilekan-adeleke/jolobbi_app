import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class OrderRepository {
  static final CollectionReference _feesRefCollectionRef =
      FirebaseFirestore.instance.collection(FEE_REF);

  Future<Map<String, dynamic>> getOrderHistory() async {
    final DocumentSnapshot documentSnapshot = await _feesRefCollectionRef
        .doc('order_fee')
        .get(const GetOptions(source: Source.server));

    return documentSnapshot.data() as Map<String, dynamic>;
  }
}