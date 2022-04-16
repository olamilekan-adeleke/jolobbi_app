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
