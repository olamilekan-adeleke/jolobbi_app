import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/utils/sizer_utils.dart';

class FoodItemCartButtonWidget extends StatelessWidget {
  const FoodItemCartButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        horizontalSpace(5),
        Expanded(
          child: CustomButton(
            color: kcBlack,
            text: 'CheckOut',
            onTap: () {},
          ),
        ),
        horizontalSpace(5),
        Expanded(
          child: CustomButton(
            text: 'CheckOut',
            onTap: () {},
          ),
        ),
        horizontalSpace(5),
      ],
    );
  }
}
