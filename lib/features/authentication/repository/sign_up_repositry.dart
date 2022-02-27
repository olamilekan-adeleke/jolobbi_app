import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jolobbi_app/features/authentication/models/sign_up_model.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class SignUpRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(USER_REF);

  Future<void> signUpUserWithEmailAndPassword(SignUpModel signUpModel) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: signUpModel.email,
      password: signUpModel.password,
    );
  }

  Future<void> saveUserDataToDataBase(SignUpModel signUpModel) async {
    final DocumentReference documentReference = userCollectionRef.doc();

    signUpModel.copyWith(id: documentReference.id);

    await documentReference.set(signUpModel.toMap());
  }
}
