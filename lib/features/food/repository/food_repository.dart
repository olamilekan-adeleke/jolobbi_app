import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class FoodRepository {
  static final CollectionReference foodVendorCollectionRef =
      FirebaseFirestore.instance.collection(FOOD_VENDOR_REF);

  Future<List<Map<String, dynamic>>> getFoodVendor({
    int limit = 10,
    String? lastDocId,
  }) async {
    Query query = foodVendorCollectionRef.limit(10);

    if (lastDocId != null) {
      query = query.startAfter([lastDocId]);
    }

    QuerySnapshot querySnapshot = await query.get();

    final List<dynamic> rawDataList =
        querySnapshot.docs.map((e) => e.data()).toList();

    // log(json.encode(rawDataList));

    List<Map<String, dynamic>> dataList =
        rawDataList.map((e) => Map<String, dynamic>.from(e)).toList();

    return dataList;
  }
}
