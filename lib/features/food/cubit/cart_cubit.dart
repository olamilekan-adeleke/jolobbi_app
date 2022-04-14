import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/cart_item_model.dart';
import '../model/cart_list_state_model.dart';

class CartCubit extends Cubit<CartListStateModel> {
  CartCubit() : super(CartListStateModel());

  void addFoodItemToCart(CartItemModel cartItem) {
    emit(state.copyWith(cartItems: [...state.cartItems, cartItem]));

    log('cart: ${state.toString()}');
  }

  int getCartItemCount(CartItemModel cart) {
    return 0;
  }
}
