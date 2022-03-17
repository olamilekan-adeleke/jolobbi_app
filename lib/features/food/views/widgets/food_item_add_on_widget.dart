import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../model/food_item_data_model.dart';

class FoodItemAddOnListViewWidget extends StatelessWidget {
  const FoodItemAddOnListViewWidget(this.addOns, {Key? key}) : super(key: key);

  final List<AddOn> addOns;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: addOns.length,
      itemBuilder: (_, int index) {
        final AddOn addOn = addOns[index];

        return FoodItemAddOnWidget(addOn);
      },
    );
  }
}

class FoodItemAddOnWidget extends StatelessWidget {
  const FoodItemAddOnWidget(this.addOn, {Key? key}) : super(key: key);

  final AddOn addOn;

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
              imageUrl: addOn.image,
              imageTypes: ImageTypes.network,
            ),
          ),
          horizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                addOn.name,
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
              ),
              TextWidget(
                'NGN ${currencyFormatter(addOn.price)}',
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
