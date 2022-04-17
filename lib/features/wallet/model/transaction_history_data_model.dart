import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistory {
  final int? amount;
  final String description;
  final Timestamp timestamp;
  final String type;
  final String? vendorTag;
  final Map<String, dynamic> transactionData;

  TransactionHistory({
    this.amount,
    required this.description,
    required this.timestamp,
    required this.type,
    this.vendorTag,
    required this.transactionData,
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

  factory TransactionHistory.fromMap(Map<String, dynamic> map) {
    return TransactionHistory(
      amount: map['amount']?.toInt() ?? 0,
      description: map['description'],
      timestamp: map['timestamp'] as Timestamp,
      type: map['type'] ?? '',
      vendorTag: map['vendorTag'],
      transactionData: Map<String, dynamic>.from(map['transactionData']),
    );
  }
}
