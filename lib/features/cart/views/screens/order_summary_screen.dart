import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../../authentication/views/screens/auth_state_screen.dart';
import '../../cubit/order_cubit_state.dart';
import '../../cubit/order_fee_cubit.dart';
import '../../enum/cart_enum.dart';
import '../../model/order_details_state_model.dart';
import '../widgets/cart_address_widget.dart';
import '../widgets/order_summary_widget.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  static const String route = '/order-summary';

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<OrderFeeCubit>().getFee();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrderCubit, OrderDetailsStateModel>(
      listener: (context, state) {
        if (state.status == OrderStatus.error) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.errorText,
          );
        } else if (state.status == OrderStatus.success) {
          SnackBarService.showSuccessSnackBar(
            context: context,
            message: 'Order Successful Made!',
          );

          AppRouter.instance.navigateToAndReplaceUntil(
            AuthStateScreen.route,
          );
        }
      },
      child: CustomScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace(),
            const AppBarWidget('Confirm Order'),
            verticalSpace(20),
            TextWidget(
              'Order Summary',
              fontSize: sp(15),
              fontWeight: FontWeight.w500,
            ),
            verticalSpace(),
            const OrderSummaryWidget(),
            verticalSpace(20),
            TextWidget(
              'Address',
              fontSize: sp(15),
              fontWeight: FontWeight.w500,
            ),
            verticalSpace(),
            const CartAddressWidget(),
            const Spacer(),
            CustomButton(
              text: 'Proceed To Payment',
              onTap: () {},
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
