import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';


class FoodItemListViewTabBarWidget extends StatelessWidget {
  const FoodItemListViewTabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextWidget(
          'Newly Added',
          fontSize: sp(16),
          fontWeight: FontWeight.w500,
          textColor: kcPrimaryColor,
        ),
        TextWidget(
          'Drinks',
          fontSize: sp(14),
          fontWeight: FontWeight.w500,
          textColor: kcGrey600,
        ),
        TextWidget(
          'Snacks',
          fontSize: sp(16),
          fontWeight: FontWeight.w500,
          textColor: kcGrey600,
        ),
      ],
    );
  }
}
