import 'package:flutter/material.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/send_fund_form_widget.dart';

class SendFundToVendor extends StatelessWidget {
  const SendFundToVendor({Key? key}) : super(key: key);

  static const String route = '/send-fund';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Send Fund'),
          verticalSpace(20),
          const SendFundToVendorFormWidget(),
          verticalSpace(20),
        ],
      ),
    );
  }
}
