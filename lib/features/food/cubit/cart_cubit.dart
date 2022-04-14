import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/cart_item_model.dart';
import '../model/cart_list_state_model.dart';

class CartCubit extends Cubit<CartListStateModel> {
  CartCubit() : super(CartListStateModel());

  void addFoodItemToCart(CartItemModel cartItem) {
    if (state.cartItems.any((ele) => ele.name == cartItem.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cartItem.name);

      List<CartItemModel> cartList = state.cartItems;

      cartList[index] = cartItem;

      emit(state.copyWith(cartItems: [...cartList]));
    } else {
      emit(state.copyWith(cartItems: [...state.cartItems, cartItem]));
    }

    log('cart: ${state.toString()}');
  }

  int getCartItemCount(CartItemModel cart) {
    return 0;
  }

  void deleteCartItem(CartItemModel cart) {
    final int index =
        state.cartItems.indexWhere((ele) => ele.name == cart.name);

    List<CartItemModel> items = state.cartItems;

    items.removeAt(index);

    emit(state.copyWith(cartItems: items));
  }

  void deleteExtraCartItem(CartItemModel cart, item) {
    final int index =
        state.cartItems.indexWhere((ele) => ele.name == cart.name);

    CartItemModel _cartItem = state.cartItems[index];

    final int itemIndex =
        _cartItem.extras?.indexWhere((ele) => ele.name == item.name) ?? -1;

    final int item2Index =
        _cartItem.addOn?.indexWhere((ele) => ele.name == item.name) ?? -1;

    if (itemIndex == -1) {
      final int item2Index =
          _cartItem.addOn?.indexWhere((ele) => ele.name == item.name) ?? -1;

      List<CartAddOn> _itemsList = _cartItem.addOn ?? [];

      _itemsList.removeAt(item2Index);

      _cartItem.copyWith(addOn: _itemsList);

      // update cart in cart list
      state.cartItems[index] = _cartItem;

      emit(state);
    } else {
      List<CartExtras> _itemsList = _cartItem.extras ?? [];

      _itemsList.removeAt(itemIndex);

      _cartItem.copyWith(extras: _itemsList);

      // update cart in cart list
      state.cartItems[index] = _cartItem;

      emit(state);
    }
  }

  void getItemCount(CartItemModel cart) {}
}
