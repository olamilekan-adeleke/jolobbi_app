import 'package:flutter/material.dart';

import '../../../../../cores/components/image_widget.dart';
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
          ],
        ),
      ),
    );
  }
}
