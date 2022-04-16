import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../cubit/order_fee_cubit.dart';
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
    return CustomScaffoldWidget(
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
        ],
      ),
    );
  }
}
