import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/cart_item_model.dart';
import '../model/food_item_data_model.dart';
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
      addOn: state.addOn,
      extras: state.extras,
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

  void addAddonItem(AddOn addOn) {
    if (state.addOn.any((CartAddOn ele) => ele.name == addOn.name)) {
      final int index = state.addOn.indexWhere((ele) => ele.name == addOn.name);

      CartAddOn cartAddOnInList = state.addOn[index];

      cartAddOnInList =
          cartAddOnInList.copyWith(count: cartAddOnInList.count + 1);

      List<CartAddOn> addOnList = state.addOn;

      addOnList[index] = cartAddOnInList;

      emit(state.copyWith(addOn: [...addOnList]));
    } else {
      final CartAddOn cartAddon = CartAddOn(
        count: 1,
        image: addOn.image,
        name: addOn.name,
        price: addOn.price,
      );

      emit(state.copyWith(addOn: [...state.addOn, cartAddon]));
    }

    log(state.toString());
  }

  void removeAddonItem(AddOn addOn) {
    if (state.addOn.any((CartAddOn ele) => ele.name == addOn.name)) {
      final int index = state.addOn.indexWhere((ele) => ele.name == addOn.name);

      CartAddOn cartAddonInList = state.addOn[index];

      if (cartAddonInList.count > 1) {
        cartAddonInList =
            cartAddonInList.copyWith(count: cartAddonInList.count - 1);

        List<CartAddOn> extraList = state.addOn;

        extraList[index] = cartAddonInList;

        emit(state.copyWith(addOn: [...extraList]));
      } else {
        state.addOn.removeAt(index);

        emit(state.copyWith(addOn: [...state.addOn]));
      }
    }

    log(state.toString());
  }

  int getExtraCount(Extras extra) {
    if (state.extras.any((CartExtras ele) => ele.name == extra.name)) {
      final int index =
          state.extras.indexWhere((ele) => ele.name == extra.name);
      return state.extras[index].count;
    } else {
      return 0;
    }
  }

  int getAddOnCount(AddOn addOn) {
    if (state.addOn.any((CartAddOn ele) => ele.name == addOn.name)) {
      final int index = state.addOn.indexWhere((ele) => ele.name == addOn.name);
      return state.addOn[index].count;
    } else {
      return 0;
    }
  }
}
