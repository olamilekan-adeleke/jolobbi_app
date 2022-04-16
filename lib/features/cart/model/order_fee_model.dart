

class OrderFeeModel {
  final int deliveryFee;
  final int serviceFee;

  OrderFeeModel({
    required this.deliveryFee,
    required this.serviceFee,
  });

  Map<String, dynamic> toMap() {
    return {
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
    };
  }

  factory OrderFeeModel.fromMap(Map<String, dynamic> map) {
    return OrderFeeModel(
      deliveryFee: map['deliveryFee']?.toInt() ?? 0,
      serviceFee: map['serviceFee']?.toInt() ?? 0,
    );
  }
}
