import 'package:cloud_firestore/cloud_firestore.dart';

import '../../profile/model/user_profile_data_model.dart';
import '../cubit/cart_item_model.dart';

class OrderDataModel {
  final List<CartItemModel> items;
  final AddressModel address;
  final int deliveryFee;
  final int serviceFee;
  final int totalFee;
  final bool hasRated;
  final String orderId;
  // pending, processing, enroute, completed, rejected,
  final String orderStatus;
  final List<String> vendorNameList;
  final UserProfileDataModel userData;
  final String userId;
  final Timestamp? timestamp;

  OrderDataModel({
    required this.items,
    required this.address,
    required this.deliveryFee,
    required this.serviceFee,
    required this.totalFee,
    this.hasRated = false,
    required this.orderId,
    this.orderStatus = 'pending',
    required this.vendorNameList,
    required this.userData,
    required this.userId,
    this.timestamp,
  });

  Map<String, dynamic> toMapForInitOrder() {
    final _userData = userData.toMap();
    userData.toMap().remove('address');

    return {
      'items': items.map((x) => x.toMap()).toList(),
      'address': address.toMap(),
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'totalFee': totalFee,
      'hasRated': hasRated,
      'orderId': orderId,
      'orderStatus': orderStatus,
      'vendorNameList': vendorNameList,
      'userData': _userData,
      'userId': userId,
      'timestamp': Timestamp.now(),
    };
  }

  factory OrderDataModel.fromMap(Map<String, dynamic> map) {
    return OrderDataModel(
      items: List<CartItemModel>.from(
          map['items']?.map((x) => CartItemModel.fromMap(x))),
      address: AddressModel.fromMap(map['address']),
      deliveryFee: map['deliveryFee']?.toInt() ?? 0,
      serviceFee: map['serviceFee']?.toInt() ?? 0,
      totalFee: map['totalFee']?.toInt() ?? 0,
      hasRated: map['hasRated'] ?? false,
      orderId: map['orderId'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      vendorNameList: List<String>.from(map['vendorNameList']),
      userData: UserProfileDataModel.fromMap(map['userData']),
      userId: map['userId'] ?? '',
    );
  }
}
