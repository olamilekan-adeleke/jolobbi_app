import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class ProfileRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);

  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final String? uid = getCurrentUserId();

    if (uid == null) {
      throw 'Error: User not login';
    }

    final DocumentSnapshot documentSnapshot =
        await userCollectionRef.doc(uid).get();

    if (documentSnapshot.data() == null) {
      throw 'Data Not Found! ';
    }

    return Map<String, dynamic>.from(documentSnapshot.data() as Map);
  }
}
