import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cores/utils/local_storage.dart';
import '../enum/cart_enum.dart';
import '../model/cart_list_state_model.dart';
import 'cart_item_model.dart';

class CartCubit extends Cubit<CartListStateModel> {
  CartCubit() : super(CartListStateModel()) {
    getCachedCartData();
  }

  static final LocalStorage _localStorage = LocalStorage.instance;

  Future<void> getCachedCartData() async {
    List<Map<String, dynamic>>? data = await _localStorage.getCartItem();

    if (data == null) return;

    List<CartItemModel> cartList =
        data.map((ele) => CartItemModel.fromMap(ele)).toList();

    emit(state.copyWith(cartItems: cartList));
  }

  void addFoodItemToCart(CartItemModel cartItem) {
    if (state.cartItems.any((ele) => ele.name == cartItem.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cartItem.name);

      List<CartItemModel> cartList = state.cartItems;

      cartList[index] = cartItem;

      emit(state.copyWith(
        cartItems: [...cartList],
        status: CartStatus.addedToCart,
      ));
    } else {
      emit(state.copyWith(
        cartItems: [...state.cartItems, cartItem],
        status: CartStatus.addedToCart,
      ));
    }

    log('cart: ${state.toString()}');

    // update local storage
    List<Map<String, dynamic>> dataToSave =
        state.cartItems.map((ele) => ele.toMap()).toList();
    _localStorage.saveCartItem(dataToSave);
  }

  void deleteCartItem(CartItemModel cart) {
    final int index =
        state.cartItems.indexWhere((ele) => ele.name == cart.name);

    List<CartItemModel> items = state.cartItems;

    items.removeAt(index);

    emit(state.copyWith(cartItems: items));

    // update local storage
    List<Map<String, dynamic>> dataToSave =
        state.cartItems.map((ele) => ele.toMap()).toList();
    _localStorage.saveCartItem(dataToSave);
  }

  void deleteExtraCartItem(CartItemModel cart, item) {
    final int index =
        state.cartItems.indexWhere((ele) => ele.name == cart.name);

    CartItemModel _cartItem = state.cartItems[index];

    final int itemIndex =
        _cartItem.extras?.indexWhere((ele) => ele.name == item.name) ?? -1;

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
      List<CartAddOn> _itemsList = _cartItem.extras ?? [];

      _itemsList.removeAt(itemIndex);

      _cartItem.copyWith(extras: _itemsList);

      // update cart in cart list
      state.cartItems[index] = _cartItem;

      emit(state);
    }

    // update local storage
    List<Map<String, dynamic>> dataToSave =
        state.cartItems.map((ele) => ele.toMap()).toList();
    _localStorage.saveCartItem(dataToSave);
  }

  int getCartItemCount(CartItemModel cart) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);
      return state.cartItems[index].count;
    } else {
      return 0;
    }
  }

  void incrementCartItem(CartItemModel cart) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);

      CartItemModel cartInList = state.cartItems[index];

      cartInList = cartInList.copyWith(count: cartInList.count + 1);

      List<CartItemModel> list = state.cartItems;

      list[index] = cartInList;

      emit(state.copyWith(cartItems: list));

      // update local storage
      List<Map<String, dynamic>> dataToSave =
          state.cartItems.map((ele) => ele.toMap()).toList();
      _localStorage.saveCartItem(dataToSave);
    }
  }

  void decrementCartItem(CartItemModel cart) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);

      CartItemModel cartInList = state.cartItems[index];

      if (cartInList.count == 1) return;

      cartInList = cartInList.copyWith(count: cartInList.count - 1);

      List<CartItemModel> list = state.cartItems;

      list[index] = cartInList;

      emit(state.copyWith(cartItems: list));

      // update local storage
      List<Map<String, dynamic>> dataToSave =
          state.cartItems.map((ele) => ele.toMap()).toList();
      _localStorage.saveCartItem(dataToSave);
    }
  }

  int getCartSubItemCount(CartItemModel cart, CartAddOn subItem) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);

      CartItemModel _cart = state.cartItems[index];

      // check extra list

      final int? extraIndex =
          _cart.extras?.indexWhere((ele) => ele.name == subItem.name);

      if (extraIndex == null || extraIndex == -1) {
        //check addon list
        final int? addonIndex =
            _cart.addOn?.indexWhere((ele) => ele.name == subItem.name);

        return _cart.addOn![addonIndex ?? 0].count;
      } else {
        return _cart.extras![extraIndex].count;
      }
    } else {
      return 0;
    }
  }

  void incrementCartSubItemCount(CartItemModel cart, CartAddOn subItem) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);

      CartItemModel _cart = state.cartItems[index];

      // check extra list

      final int? extraIndex =
          _cart.extras?.indexWhere((ele) => ele.name == subItem.name);

      if (extraIndex == null || extraIndex == -1) {
        //check addon list
        final int? addonIndex =
            _cart.addOn?.indexWhere((ele) => ele.name == subItem.name);

        CartAddOn _extraItem = _cart.addOn![addonIndex!];

        if (_extraItem.count == 10) return;

        _extraItem = _extraItem.copyWith(count: _extraItem.count + 1);

        _cart.addOn![addonIndex] = _extraItem;
      } else {
        CartAddOn _extraItem = _cart.extras![extraIndex];

        if (_extraItem.count == 10) return;

        _extraItem = _extraItem.copyWith(count: _extraItem.count + 1);

        _cart.extras![extraIndex] = _extraItem;
      }

      List<CartItemModel> list = state.cartItems;

      list[index] = _cart;

      emit(state.copyWith(cartItems: list));
    }

    // update local storage
    List<Map<String, dynamic>> dataToSave =
        state.cartItems.map((ele) => ele.toMap()).toList();
    _localStorage.saveCartItem(dataToSave);
  }

  void decrementCartSubItemCount(CartItemModel cart, CartAddOn subItem) {
    if (state.cartItems.any((CartItemModel ele) => ele.name == cart.name)) {
      final int index =
          state.cartItems.indexWhere((ele) => ele.name == cart.name);

      CartItemModel _cart = state.cartItems[index];

      // check extra list

      final int? extraIndex =
          _cart.extras?.indexWhere((ele) => ele.name == subItem.name);

      if (extraIndex == null || extraIndex == -1) {
        //check addon list
        final int? addonIndex =
            _cart.addOn?.indexWhere((ele) => ele.name == subItem.name);

        CartAddOn _extraItem = _cart.addOn![addonIndex!];

        if (_extraItem.count == 1) return;

        _extraItem = _extraItem.copyWith(count: _extraItem.count - 1);

        _cart.addOn![addonIndex] = _extraItem;
      } else {
        CartAddOn _extraItem = _cart.extras![extraIndex];

        if (_extraItem.count == 1) return;

        _extraItem = _extraItem.copyWith(count: _extraItem.count - 1);

        _cart.extras![extraIndex] = _extraItem;
      }

      List<CartItemModel> list = state.cartItems;

      list[index] = _cart;

      emit(state.copyWith(cartItems: list));
    }
    // update local storage
    List<Map<String, dynamic>> dataToSave =
        state.cartItems.map((ele) => ele.toMap()).toList();
    _localStorage.saveCartItem(dataToSave);
  }

  int itemTotalPrice() {
    int extraTotal = 0;
    int addOnTotal = 0;
    int itemTotal = 0;

    for (var ele in state.cartItems) {
      ele.extras?.forEach((item) {
        extraTotal += item.price * item.count;
      });
    }

    for (var ele in state.cartItems) {
      ele.addOn?.forEach((item) {
        addOnTotal += item.price * item.count;
      });
    }

    for (var ele in state.cartItems) {
      itemTotal += ele.price * ele.count;
    }

    return extraTotal + addOnTotal + itemTotal;
  }

  void clearCart() {
    emit(state.copyWith(cartItems: []));

    // update local storage
    // List<Map<String, dynamic>> dataToSave =
    //     state.cartItems.map((ele) => ele.toMap()).toList();
    // _localStorage.saveCartItem(dataToSave);
  }
}
