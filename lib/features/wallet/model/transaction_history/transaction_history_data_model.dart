import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistoryDataModel {
  final int? amount;
  final String description;
  final Timestamp timestamp;
  final String type;
  final String? vendorTag;
  final Map<String, dynamic>? transactionData;

  TransactionHistoryDataModel({
    this.amount,
    required this.description,
    required this.timestamp,
    required this.type,
    this.vendorTag,
    this.transactionData,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'timestamp': timestamp,
      'type': type,
      'vendorTag': vendorTag,
      'transactionData': transactionData,
    };
  }

  factory TransactionHistoryDataModel.fromMap(Map<String, dynamic> map) {
    return TransactionHistoryDataModel(
      amount: map['amount']?.toInt() ?? 0,
      description: map['description'],
      timestamp: map['timestamp'] as Timestamp,
      type: map['type'] ?? '',
      vendorTag: map['vendorTag'],
      transactionData: map['transactionData'] == null
          ? null
          : Map<String, dynamic>.from(map['transactionData']),
    );
  }
}
