import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class ProfileRepository {
  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);


      

  Future<Map<String, dynamic>> getUserData() async {
    // await userCollectionRef.doc()

    return {};
  }
}
