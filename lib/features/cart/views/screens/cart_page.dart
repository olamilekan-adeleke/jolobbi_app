import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_item_model.dart';
import '../../model/cart_list_state_model.dart';
import '../widgets/cart_icon_widget.dart';
import '../widgets/cart_item_widget.dart';
import 'order_summary_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String route = '/cart';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      // useSingleScroll: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('My Cart', trilling: CartIconWidget()),
          verticalSpace(),
          BlocBuilder<CartCubit, CartListStateModel>(
            builder: (context, state) {
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.cartItems.length,
                  itemBuilder: (_, int index) {
                    final CartItemModel cartItem = state.cartItems[index];

                    return CartItemWidget(cartItem);
                  },
                ),
              );
            },
          ),
          verticalSpace(20),
          CustomButton(
            text: 'Check Out',
            onTap: () {
              AppRouter.instance.navigateTo(OrderSummaryScreen.route);
            },
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}
