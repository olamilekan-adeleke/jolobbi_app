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

  static final CollectionReference drinksCollectionRef =
      FirebaseFirestore.instance.collection(DRINK_ITEMS_REF);

  static final CollectionReference snacksCollectionRef =
      FirebaseFirestore.instance.collection(SNACK_ITEMS_REF);

  Future<List<Map<String, dynamic>>> getFoodVendor({
    int limit = 10,
    String? lastDocId,
    String? searchQuery,
  }) async {
    Query query = foodVendorCollectionRef.limit(limit).orderBy('id');

    if (lastDocId != null) {
      query = query.startAfter([lastDocId]);
    }

    if (searchQuery != null) {
      query = query.where('search_key', arrayContains: searchQuery);
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
    String? vendorId,
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
        .limit(limit)
        .where('type', isEqualTo: 'food')
        .orderBy('id')
        .orderBy('time_added');

    // geoFlutterFire
    //     .collection(collectionRef: foodItemCollectionRef)
    //     .within(center: center, radius: 5, field: 'g');

    if (lastDocId != null) {
      query = query.startAfter([lastDocId, timeAdded]);
    }

    if (vendorId != null) {
      query = query.where('fast_food_id', isEqualTo: vendorId);
    }

    QuerySnapshot querySnapshot = await query.get();

    final List<dynamic> rawDataList =
        querySnapshot.docs.map((e) => e.data()).toList();

    // log(json.encode(rawDataList));

    List<Map<String, dynamic>> dataList =
        rawDataList.map((e) => Map<String, dynamic>.from(e)).toList();

    return dataList;
  }

  Future<List<Map<String, dynamic>>> getDrinkItem({
    int limit = 10,
    String? lastDocId,
    int? timeAdded,
    String? vendorId,
  }) async {
    Query query = drinksCollectionRef
        .limit(limit)
        .where('type', isEqualTo: 'drinks')
        .orderBy('id')
        .orderBy('time_added');

    if (lastDocId != null) {
      query = query.startAfter([lastDocId, timeAdded]);
    }

    if (vendorId != null) {
      query = query.where('fast_food_id', isEqualTo: vendorId);
    }

    QuerySnapshot querySnapshot = await query.get();

    final List<dynamic> rawDataList =
        querySnapshot.docs.map((e) => e.data()).toList();

    List<Map<String, dynamic>> dataList =
        rawDataList.map((e) => Map<String, dynamic>.from(e)).toList();

    return dataList;
  }

  Future<List<Map<String, dynamic>>> getSnackItem({
    int limit = 10,
    String? lastDocId,
    int? timeAdded,
    String? vendorId,
  }) async {
    Query query = snacksCollectionRef
        .limit(limit)
        .where('type', isEqualTo: 'snacks')
        .orderBy('id')
        .orderBy('time_added');

    if (lastDocId != null) {
      query = query.startAfter([lastDocId, timeAdded]);
    }

    if (vendorId != null) {
      query = query.where('fast_food_id', isEqualTo: vendorId);
    }

    QuerySnapshot querySnapshot = await query.get();

    final List<dynamic> rawDataList =
        querySnapshot.docs.map((e) => e.data()).toList();

    List<Map<String, dynamic>> dataList =
        rawDataList.map((e) => Map<String, dynamic>.from(e)).toList();

    return dataList;
  }
}
