import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../profile/model/user_profile_data_model.dart';
import '../enum/cart_enum.dart';
import '../model/order_data_model.dart';
import '../model/order_details_state_model.dart';
import '../service/order_service.dart';
import 'cart_item_model.dart';

class AddOrderCubit extends Cubit<OrderDetailsStateModel> {
  AddOrderCubit() : super(OrderDetailsStateModel());

  static final OrderService _orderService = OrderService();

  void onAddressChange(AddressModel address) {
    emit(state.copyWith(status: OrderStatus.unknown, address: address));
  }

  Future<void> createOrder({
    required List<CartItemModel> items,
    required int deliveryFee,
    required int serviceFee,
    required UserProfileDataModel userData,
  }) async {
    try {
      emit(state.copyWith(status: OrderStatus.busy));

      if (state.address == null) throw 'Please Select Address!';

      final OrderDataModel order = OrderDataModel(
        orderId: const Uuid().v1(),
        items: items,
        address: state.address!,
        deliveryFee: deliveryFee,
        serviceFee: serviceFee,
        totalFee: getTotalPrice(items),
        vendorNameList: getVendorNameList(items),
        userData: userData,
        userId: userData.id,
      );

      await _orderService.addOrder(order);

      emit(state.copyWith(status: OrderStatus.success));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(status: OrderStatus.error, errorText: '$e'));
    }
  }

  List<String> getVendorNameList(List<CartItemModel> items) {
    final List<String> vendorNameList = <String>[];

    for (var ele in items) {
      vendorNameList.add(ele.fastFoodName);
    }

    return vendorNameList;
  }

  int getTotalPrice(List<CartItemModel> items) {
    int extraTotal = 0;
    int addOnTotal = 0;
    int itemTotal = 0;

    for (var ele in items) {
      ele.extras?.forEach((item) {
        extraTotal += item.price * item.count;
      });
    }

    for (var ele in items) {
      ele.addOn?.forEach((item) {
        addOnTotal += item.price * item.count;
      });
    }

    for (var ele in items) {
      itemTotal += ele.price * ele.count;
    }

    return extraTotal + addOnTotal + itemTotal;
  }
}
