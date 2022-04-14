import 'cart_item_model.dart';

class CartListStateModel {
  List<CartItemModel> cartItems = [];

  CartListStateModel({
    List<CartItemModel>? foodItem,
  }) : cartItems = foodItem ?? [];

  CartListStateModel copyWith({
    List<CartItemModel>? cartItems,
  }) {
    return CartListStateModel(
      foodItem: cartItems ?? this.cartItems,
    );
  }

  @override
  String toString() => 'CartListStateModel(foodItem: $cartItems)';
}
