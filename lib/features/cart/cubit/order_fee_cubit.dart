import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/cart_enum.dart';
import '../model/order_fee_model.dart';
import '../service/order_service.dart';

class OrderFeeCubit extends Cubit<OrderFeeModel> {
  OrderFeeCubit() : super(OrderFeeModel());

  static final OrderService _orderService = OrderService();

  Future<void> getFee() async {
    try {
      emit(state.copyWith(errorText: '', status: CartStatus.busy));

      final OrderFeeModel orderFee = await _orderService.getFeeData();

      emit(
        state.copyWith(
          status: CartStatus.success,
          deliveryFee: orderFee.deliveryFee,
          serviceFee: orderFee.serviceFee,
        ),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(errorText: '$e', status: CartStatus.error));
    }
  }
}
