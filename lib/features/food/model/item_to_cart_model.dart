import 'cart_item_model.dart';

class ItemToCartModel {
  final CartItemModel? foodItem;

  ItemToCartModel({this.foodItem});

  ItemToCartModel copyWith({
    CartItemModel? foodItem,
  }) {
    return ItemToCartModel(
      foodItem: foodItem ?? this.foodItem,
    );
  }

  @override
  String toString() => 'ItemToCartModel(foodItem: $foodItem)';
}
