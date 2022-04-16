import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/error_widget.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/order_fee_cubit.dart';
import '../../enum/cart_enum.dart';
import '../../model/order_fee_model.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = context.read<CartCubit>();

    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sp(10), vertical: sp(10)),
        child: BlocBuilder<OrderFeeCubit, OrderFeeModel>(
          builder: (context, state) {
            final bool isLoading = state.status == CartStatus.busy;

            if (state.status == CartStatus.error) {
              return CustomErrorWidget(
                message: state.errorText,
                callback: context.read<OrderFeeCubit>().getFee,
              );
            }

            return Column(
              children: <Widget>[
                itemWidget(
                    'Items', cartCubit.state.cartItems.length.toString()),
                itemWidget(
                  'Items Total',
                  'NGN ${currencyFormatter(cartCubit.itemTotalPrice())}',
                ),
                itemWidget(
                  'Delivery Fee',
                  isLoading
                      ? 'Loading....'
                      : 'NGN ${currencyFormatter(state.deliveryFee)}',
                ),
                itemWidget(
                  'Service Fee',
                  isLoading
                      ? 'Loading....'
                      : 'NGN ${currencyFormatter(state.serviceFee)}',
                ),
                itemWidget(
                  'Total',
                  'NGN ${currencyFormatter(2500)}',
                  true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemWidget(String title, String amount, [bool isTotal = false]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(
              title,
              fontSize: sp(14),
              fontWeight: FontWeight.w300,
            ),
            TextWidget(
              amount,
              fontSize: sp(isTotal ? 15 : 14),
              fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
