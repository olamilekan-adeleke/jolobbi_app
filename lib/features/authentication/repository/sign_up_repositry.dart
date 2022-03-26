import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cores/constants/firebase_collection_key.dart';
import '../models/sign_up_model.dart';

class SignUpRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);

  Future<String?> signUpUserWithEmailAndPassword(
      SignUpModel signUpModel) async {
    final UserCredential data =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: signUpModel.email,
      password: signUpModel.password,
    );

    return data.user?.uid;
  }

  Future<void> saveUserDataToDataBase(SignUpModel signUpModel) async {
    final DocumentReference documentReference =
        userCollectionRef.doc(signUpModel.id);

    await documentReference.set(signUpModel.toMap());
  }
}
