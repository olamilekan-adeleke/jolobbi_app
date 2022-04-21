import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/model/user_profile_data_model.dart';
import '../enum/cart_enum.dart';
import '../model/order_details_state_model.dart';

class AddOrderCubit extends Cubit<OrderDetailsStateModel> {
  AddOrderCubit() : super(OrderDetailsStateModel());

  void onAddressChange(AddressModel address) {
    emit(state.copyWith(status: OrderStatus.unknown, address: address));
  }

  void createOrder() {
    try {
      emit(state.copyWith(status: OrderStatus.busy));

      emit(state.copyWith(status: OrderStatus.success));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(status: OrderStatus.error, errorText: '$e'));
    }
  }
}
