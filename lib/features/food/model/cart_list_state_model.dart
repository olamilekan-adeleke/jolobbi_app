import 'cart_item_model.dart';

class CartListStateModel {
  List<CartItemModel> foodItem = [];

  CartListStateModel({
    List<CartItemModel>? foodItem,
  }) : foodItem = foodItem ?? [];

  CartListStateModel copyWith({
    List<CartItemModel>? foodItem,
  }) {
    return CartListStateModel(
      foodItem: foodItem ?? this.foodItem,
    );
  }

  @override
  String toString() => 'CartListStateModel(foodItem: $foodItem)';
}
