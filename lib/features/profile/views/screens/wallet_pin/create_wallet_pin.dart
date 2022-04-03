import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/constants/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_button.dart';
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
            'You\'ll use this pin for verification any time you want to make a transaction on your wallet 🔐, make sure only you know it 🤫',
            fontSize: sp(12),
            textColor: kcSubTextColor,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
          ),
          verticalSpace(40),
          PinCodeTextField(
            appContext: context,
            length: 4,
            obscureText: true,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              inactiveColor: kcGrey600,
              selectedColor: kcTextColor,
            ),
            onChanged: (value) {},
          ),
          const Spacer(),
          CustomButton(text: 'Create Pin', onTap: () {}),
          verticalSpace(40),
        ],
      ),
    );
  }
}
