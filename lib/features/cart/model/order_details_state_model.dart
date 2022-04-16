import 'package:jolobbi_app/features/cart/model/order_data_model.dart';

import '../enum/cart_enum.dart';

class OrderDetailsStateModel {
  final OrderDataModel? orderData;
  final OrderStatus status;
  final String errorText;

  OrderDetailsStateModel({
    this.orderData,
    this.status = OrderStatus.unknown,
    this.errorText = '',
  });

  OrderDetailsStateModel copyWith({
    OrderDataModel? orderData,
    OrderStatus? status,
    String? errorText,
  }) {
    return OrderDetailsStateModel(
      orderData: orderData ?? this.orderData,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
