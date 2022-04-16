import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../widgets/order_summary_widget.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  static const String route = '/order-summary';

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
