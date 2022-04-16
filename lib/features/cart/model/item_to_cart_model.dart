import '../cubit/cart_item_model.dart';


class ItemToCartModel {
  final CartItemModel? foodItem;
  List<CartAddOn> addOn = [];
  List<CartAddOn> extras = [];

  ItemToCartModel({
    this.foodItem,
    final List<CartAddOn>? addOn,
    final List<CartAddOn>? extras,
  })  : addOn = addOn ?? [],
        extras = extras ?? [];

  @override
  String toString() =>
      'ItemToCartModel(foodItem: $foodItem, addOn: $addOn, extras: $extras)';

  ItemToCartModel copyWith({
    CartItemModel? foodItem,
    List<CartAddOn>? addOn,
    List<CartAddOn>? extras,
  }) {
    return ItemToCartModel(
      foodItem: foodItem ?? this.foodItem,
      addOn: addOn ?? this.addOn,
      extras: extras ?? this.extras,
    );
  }
}
