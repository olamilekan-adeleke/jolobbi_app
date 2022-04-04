import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class UpdateAddressRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);

  Future<void> addAddress(Map<String, dynamic> data) async {
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw 'Error: User not login';
    }
    await userCollectionRef.doc(userId).update(
      <String, dynamic>{
        'address': FieldValue.arrayUnion([data]),
      },
    );
  }
}
