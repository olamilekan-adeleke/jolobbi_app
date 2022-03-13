import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';

class FoodItemReviewListViewWidget extends StatelessWidget {
  const FoodItemReviewListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, int index) {
        return const _FoodItemReviewWidget();
      },
    );
  }
}

class _FoodItemReviewWidget extends StatelessWidget {
  const _FoodItemReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(
              height: sp(30),
              width: sp(30),
              child: const CustomImageWidget(
                imageUrl: 'assets/images/review.png',
                imageTypes: ImageTypes.asset,
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget('Sammy Abdulsemiu', fontSize: sp(16)),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: sp(13),
                      color: kcPrimaryColor,
                    ),
                    Icon(
                      Icons.star,
                      size: sp(13),
                      color: kcPrimaryColor,
                    ),
                    Icon(
                      Icons.star,
                      size: sp(13),
                      color: kcPrimaryColor,
                    ),
                    Icon(
                      Icons.star,
                      size: sp(13),
                      color: kcPrimaryColor,
                    ),
                    Icon(
                      Icons.star,
                      size: sp(13),
                      color: kcPrimaryColor,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        verticalSpace(),
        TextWidget(
          'The ITEM 7 jollof rice with chicken is rich in protein and its taste is very nutritious.',
          fontSize: sp(14),
          fontWeight: FontWeight.w300,
        ),
        verticalSpace(),
      ],
    );
  }
}
