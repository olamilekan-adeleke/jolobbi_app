import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/model/food_item_data_model.dart';

import '../model/cart_item_model.dart';
import '../model/item_to_cart_model.dart';

class ItemToCartCubit extends Cubit<ItemToCartModel> {
  ItemToCartCubit() : super(ItemToCartModel());

  void addFoodItemToCart(FoodItemDataModel foodItem) {
    final CartItemModel cartItem = CartItemModel(
      count: 1,
      fastFoodId: foodItem.fastFoodId,
      fastFoodName: foodItem.fastFoodName,
      id: foodItem.id,
      image: foodItem.image,
      name: foodItem.name,
      price: foodItem.price,
      type: foodItem.type,
    );

    emit(state.copyWith(foodItem: cartItem));

    log(state.toString());
  }

  void addExtraItem(FoodItemDataModel foodItem, Extras extra) {
    CartItemModel cartItem = CartItemModel(
      count: 1,
      fastFoodId: foodItem.fastFoodId,
      fastFoodName: foodItem.fastFoodName,
      id: foodItem.id,
      image: foodItem.image,
      name: foodItem.name,
      price: foodItem.price,
      type: foodItem.type,
    );

    final CartExtras cartExtra = CartExtras(
      count: 1,
      image: extra.image,
      name: extra.name,
      price: extra.price,
    );

    int index = state.foodItem?.extras?.indexWhere((ele) =>
            ele.name == cartExtra.name && ele.image == cartExtra.image) ??
        -1;

    if (index >= 0) {
      final CartExtras updatedCartExtra =
          cartExtra.copyWith(count: cartExtra.count + 1);

      final int extraIndex = state.foodItem!.extras!
          .indexWhere((ele) => ele.name == cartExtra.name);

      state.foodItem!.extras![extraIndex] = updatedCartExtra;

      cartItem = state.foodItem!;
    } else {
      cartItem = cartItem.copyWith(extras: [cartExtra]);
    }

    emit(state.copyWith(foodItem: cartItem));

    log(state.toString());
  }
}
