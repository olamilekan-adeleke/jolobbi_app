import 'cart_item_model.dart';

class ItemToCartModel {
  final CartItemModel? foodItem;
  List<CartAddOn> addOn = [];
  List<CartExtras> extras = [];

  ItemToCartModel({
    this.foodItem,
    final List<CartAddOn>? addOn,
    final List<CartExtras>? extras,
  })  : addOn = addOn ?? [],
        extras = extras ?? [];

  @override
  String toString() =>
      'ItemToCartModel(foodItem: $foodItem, addOn: $addOn, extras: $extras)';

  ItemToCartModel copyWith({
    CartItemModel? foodItem,
    List<CartAddOn>? addOn,
    List<CartExtras>? extras,
  }) {
    return ItemToCartModel(
      foodItem: foodItem ?? this.foodItem,
      addOn: addOn ?? this.addOn,
      extras: extras ?? this.extras,
    );
  }
}
