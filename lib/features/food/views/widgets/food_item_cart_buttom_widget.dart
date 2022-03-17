import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../model/food_item_data_model.dart';

class FoodItemCartButtonWidget extends StatelessWidget {
  const FoodItemCartButtonWidget(this.foodItem, {Key? key}) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        horizontalSpace(5),
        Expanded(
          child: CustomButton(color: kcBlack, text: 'Checkout', onTap: () {}),
        ),
        horizontalSpace(5),
        Expanded(
          child: CustomButton(text: 'Add To Cart', onTap: () {}),
        ),
        horizontalSpace(5),
      ],
    );
  }
}
