import '../enum/cart_enum.dart';

class OrderFeeModel {
  final int deliveryFee;
  final int serviceFee;
  final CartStatus status;
  final String errorText;

  OrderFeeModel({
    this.deliveryFee = 0,
    this.serviceFee = 0,
    this.status = CartStatus.unknown,
    this.errorText = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'delivery_fee': deliveryFee,
      'service_fee': serviceFee,
    };
  }

  factory OrderFeeModel.fromMap(Map<String, dynamic> map) {
    return OrderFeeModel(
      deliveryFee: map['delivery_fee']?.toInt() ?? 0,
      serviceFee: map['service_fee']?.toInt() ?? 0,
    );
  }

  OrderFeeModel copyWith({
    int? deliveryFee,
    int? serviceFee,
    CartStatus? status,
    String? errorText,
  }) {
    return OrderFeeModel(
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
