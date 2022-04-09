import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/custom_button.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/utils/sizer_utils.dart';

class FundWalletAmountWidget extends StatelessWidget {
  const FundWalletAmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: sp(5),
            width: sp(42),
            decoration: BoxDecoration(
              color: const Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(sp(25)),
            ),
          ),
        ),
        verticalSpace(30),
        TextWidget(
          'Enter Amount',
          fontSize: sp(14),
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(5),
        CustomTextField(
          hintText: 'NGN 1,000',
          onChanged: (_) {},
        ),
        verticalSpace(40),
        CustomButton(text: 'Proceed To Payment', onTap: () {}),
      ],
    );
  }
}
