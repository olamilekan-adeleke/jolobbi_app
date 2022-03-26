// import 'dart:convert';
// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';
// import 'package:location/location.dart';

import '../../../cores/constants/firebase_collection_key.dart';

class FoodRepository {
  // final GeoFlutterFire geoFlutterFire = GeoFlutterFire();
  // final Location location = Location();

  static final CollectionReference foodVendorCollectionRef =
      FirebaseFirestore.instance.collection(FOOD_VENDOR_REF);
  static final CollectionReference foodItemCollectionRef =
      FirebaseFirestore.instance.collection(FOOD_ITEMS_REF);

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

  Future<List<Map<String, dynamic>>> getFoodItem({
    int limit = 10,
    String? lastDocId,
    int? timeAdded,
  }) async {
    // LocationData locationData = await location.getLocation();

    // if (locationData.latitude == null || locationData.longitude == null) {
    //   throw 'Unable to get location!';
    // }

    // final GeoFirePoint center = geoFlutterFire.point(
    //   latitude: locationData.latitude!,
    //   longitude: locationData.longitude!,
    // );

    Query query = foodItemCollectionRef
        .limit(10)
        .where('type', isEqualTo: 'food')
        .orderBy('id')
        .orderBy('time_added');

    // geoFlutterFire
    //     .collection(collectionRef: foodItemCollectionRef)
    //     .within(center: center, radius: 5, field: 'g');

    if (lastDocId != null) {
      query = query.startAfter([lastDocId, timeAdded]);
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
