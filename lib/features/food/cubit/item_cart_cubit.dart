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

  void addExtraItem(Extras extra) {
    if (state.extras.any((CartExtras ele) => ele.name == extra.name)) {
      final int index =
          state.extras.indexWhere((ele) => ele.name == extra.name);

      CartExtras cartExtraInList = state.extras[index];

      cartExtraInList =
          cartExtraInList.copyWith(count: cartExtraInList.count + 1);

      List<CartExtras> extraList = state.extras;

      extraList[index] = cartExtraInList;

      emit(state.copyWith(extras: [...extraList]));
    } else {
      final CartExtras cartExtra = CartExtras(
        count: 1,
        image: extra.image,
        name: extra.name,
        price: extra.price,
      );

      emit(state.copyWith(extras: [...state.extras, cartExtra]));
    }

    log(state.toString());
  }

  void removeExtraItem(Extras extra) {
    if (state.extras.any((CartExtras ele) => ele.name == extra.name)) {
      final int index =
          state.extras.indexWhere((ele) => ele.name == extra.name);

      CartExtras cartExtraInList = state.extras[index];

      if (cartExtraInList.count > 1) {
        cartExtraInList =
            cartExtraInList.copyWith(count: cartExtraInList.count - 1);

        List<CartExtras> extraList = state.extras;

        extraList[index] = cartExtraInList;

        emit(state.copyWith(extras: [...extraList]));
      } else {
        state.extras.removeAt(index);

        emit(state.copyWith(extras: [...state.extras]));
      }
    }

    log(state.toString());
  }
}
