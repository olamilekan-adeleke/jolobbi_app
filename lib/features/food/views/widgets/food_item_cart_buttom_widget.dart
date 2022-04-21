import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/cubit/item_cart_cubit.dart';
import '../../model/food_item_data_model.dart';
import '../../../cart/views/screens/cart_page.dart';

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

              AppRouter.instance.navigateTo(CartScreen.route);

              itemToCartCubit.clear();
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

              itemToCartCubit.clear();
            },
          ),
        ),
        horizontalSpace(5),
      ],
    );
  }
}
