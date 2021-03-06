import '../../profile/model/user_profile_data_model.dart';
import '../enum/cart_enum.dart';
import 'order_data_model.dart';

class OrderDetailsStateModel {
  final OrderDataModel? orderData;
  final AddressModel? address;
  final OrderStatus status;
  final String errorText;

  OrderDetailsStateModel({
    this.orderData,
    this.address,
    this.status = OrderStatus.unknown,
    this.errorText = '',
  });

  OrderDetailsStateModel copyWith({
    OrderDataModel? orderData,
    AddressModel? address,
    OrderStatus? status,
    String? errorText,
  }) {
    return OrderDetailsStateModel(
      orderData: orderData ?? this.orderData,
      address: address ?? this.address,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
