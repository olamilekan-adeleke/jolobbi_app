import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class VendorItemListTileWidget extends StatelessWidget {
  const VendorItemListTileWidget({Key? key}) : super(key: key);

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
                child: const CustomImageWidget(
                  imageUrl:
                      'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?cs=srgb&dl=pexels-ella-olsson-1640777.jpg&fm=jpg',
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
                    'foodItem name ' * 6,
                    fontSize: sp(18),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: sp(15),
                        color: kcIconGrey,
                      ),
                      TextWidget(
                        'Tanke, Ilorin',
                        fontSize: sp(14),
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
                        size: sp(13),
                        color: kcPrimaryColor,
                      ),
                      TextWidget(
                        '4.5(253) Reviews',
                        fontSize: sp(15),
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
