import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../model/food_item_data_model.dart';

class SelectedFoodItemExtraListViewWidget extends StatelessWidget {
  const SelectedFoodItemExtraListViewWidget(this.extras, {Key? key})
      : super(key: key);

  final List<Extras> extras;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: extras.length,
      itemBuilder: (_, int index) {
        final Extras extra = extras[index];

        return _FoodItemExtraWidget(extra);
      },
    );
  }
}

class _FoodItemExtraWidget extends StatelessWidget {
  const _FoodItemExtraWidget(this.extra, {Key? key}) : super(key: key);

  final Extras extra;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sp(5)),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: sp(40),
            width: sp(40),
            child: CustomImageWidget(
              imageUrl: extra.image,
              imageTypes: ImageTypes.network,
            ),
          ),
          horizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                extra.name,
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
              ),
              TextWidget(
                'NGN ${currencyFormatter(extra.price)}',
                fontSize: sp(14),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sp(10),
              vertical: sp(5),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: kcIconGrey),
              borderRadius: BorderRadius.circular(sp(6)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.remove_circle_outline,
                  size: sp(15),
                  color: kcPrimaryColor,
                ),
                horizontalSpace(8),
                TextWidget(
                  '0',
                  fontSize: sp(14),
                  fontWeight: FontWeight.w500,
                ),
                horizontalSpace(8),
                Icon(
                  Icons.add_circle_outlined,
                  size: sp(15),
                  color: kcPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
