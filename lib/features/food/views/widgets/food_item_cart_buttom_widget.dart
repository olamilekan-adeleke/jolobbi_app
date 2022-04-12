import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/item_cart_cubit.dart';
import '../../model/food_item_data_model.dart';

class FoodItemCartButtonWidget extends StatelessWidget {
  const FoodItemCartButtonWidget(this.foodItem, {Key? key}) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    final ItemToCartCubit itemToCartCubit = context.read<ItemToCartCubit>();
    final CartCubit cartCubit = context.read<CartCubit>();

    return Row(
      children: <Widget>[
        horizontalSpace(5),
        Expanded(
          child: CustomButton(
            color: kcBlack,
            text: 'Checkout',
            onTap: () {
              itemToCartCubit.addFoodItemToCart(foodItem);

              if (itemToCartCubit.state.foodItem == null) return;

              cartCubit.addFoodItemToCart(itemToCartCubit.state.foodItem!);

              // todo: navigate to cart page
            },
          ),
        ),
        horizontalSpace(5),
        Expanded(
          child: CustomButton(
            text: 'Add To Cart',
            onTap: () {
              itemToCartCubit.addFoodItemToCart(foodItem);

              if (itemToCartCubit.state.foodItem == null) return;

              cartCubit.addFoodItemToCart(itemToCartCubit.state.foodItem!);
            },
          ),
        ),
        horizontalSpace(5),
      ],
    );
  }
}
