

import '../cubit/cart_item_model.dart';
import '../enum/cart_enum.dart';

class CartListStateModel {
  List<CartItemModel> cartItems = [];
  final CartStatus status;

  CartListStateModel({
    List<CartItemModel>? foodItem,
    this.status = CartStatus.unknown,
  }) : cartItems = foodItem ?? [];

  CartListStateModel copyWith({
    List<CartItemModel>? cartItems,
    CartStatus? status,
  }) {
    return CartListStateModel(
      foodItem: cartItems ?? this.cartItems,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'CartListStateModel(foodItem: $cartItems)';
}
