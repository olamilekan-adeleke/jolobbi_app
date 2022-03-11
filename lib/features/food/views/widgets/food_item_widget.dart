import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: sp(5)),
      height: sp(170),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(sp(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: sp(120),
            width: double.infinity,
            child: const CustomImageWidget(
              imageUrl: 'assets/images/food_2.png',
              imageTypes: ImageTypes.asset,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sp(10),
              vertical: sp(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      'Sushi Shima',
                      fontSize: sp(16),
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget(
                      'Charcoal',
                      fontSize: sp(11),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      'NGN 2,000',
                      fontSize: sp(16),
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star_rate,
                          size: sp(13),
                          color: kcPrimaryColor,
                        ),
                        horizontalSpace(2),
                        TextWidget(
                          '4.5(283)',
                          fontSize: sp(12),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
