import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../model/food_vendor_data_model.dart';

class VendorItemListTileWidget extends StatelessWidget {
  const VendorItemListTileWidget(this.foodVendor, {Key? key}) : super(key: key);

  final FoodVendorDataModel foodVendor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sp(5), vertical: sp(10)),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: sp(70),
              width: sp(70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sp(5)),
                child: CustomImageWidget(
                  imageUrl: foodVendor.image,
                  imageTypes: ImageTypes.network,
                ),
              ),
            ),
            horizontalSpace(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    foodVendor.name,
                    fontSize: sp(16),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: sp(13),
                        color: kcIconGrey,
                      ),
                      TextWidget(
                        foodVendor.location.locationName,
                        fontSize: sp(12),
                        fontWeight: FontWeight.w300,
                        textColor: kcIconGrey,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate,
                        size: sp(12),
                        color: kcPrimaryColor,
                      ),
                      TextWidget(
                        '4.5(253) Reviews',
                        fontSize: sp(13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: sp(15),
              color: kcIconGrey,
            )
          ],
        ),
      ),
    );
  }
}
