import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class CreateWalletPinPage extends StatelessWidget {
  const CreateWalletPinPage({Key? key}) : super(key: key);

  static const String route = '/create-wallet-pin';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Create Pin'),
          verticalSpace(30),
          TextWidget(
            'Create Your 4-digit Pin',
            fontSize: sp(18),
            fontWeight: FontWeight.w300,
          ),
          verticalSpace(5),
          TextWidget(
            'You\' use this pin for verification any time you want to make a transaction on your wallet',
            fontSize: sp(12),
            textColor: kcGrey300,
          ),
        ],
      ),
    );
  }
}
