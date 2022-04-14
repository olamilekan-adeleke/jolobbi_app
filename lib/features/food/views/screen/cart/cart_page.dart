import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/cart_cubit.dart';
import '../../../model/cart_item_model.dart';
import '../../../model/cart_list_state_model.dart';
import '../../widgets/cart/cart_icon_widget.dart';
import '../../widgets/cart/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String route = '/cart';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('My Cart', trilling: CartIconWidget()),
          verticalSpace(20),
          BlocBuilder<CartCubit, CartListStateModel>(
            builder: (context, state) {
              return Flexible(
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (_, int index) {
                    final CartItemModel cartItem = state.cartItems[index];

                    return CartItemWidget(cartItem);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
