import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/utils/bottom_sheet_helper.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../profile/model/user_profile_data_model.dart';
import '../../../profile/views/widgets/address/select_address_widget.dart';

class CartAddressWidget extends StatelessWidget {
  const CartAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final AddressModel? address = await BottomSheetHelper.show(
          context: context,
          child: const BottomSheetSelectAddressWidget(),
        );

        log('$address');
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sp(5), vertical: sp(8)),
          child: SizedBox(
            height: sp(60),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: sp(60),
                  width: sp(75),
                  child: const CustomImageWidget(
                    imageTypes: ImageTypes.asset,
                    imageUrl: 'assets/images/map.png',
                  ),
                ),
                horizontalSpace(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        'Office',
                        fontSize: sp(15),
                        fontWeight: FontWeight.w500,
                      ),
                      TextWidget(
                        'Your office address goes here ' * 34,
                        fontSize: sp(12),
                        fontWeight: FontWeight.w300,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                horizontalSpace(5),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit_location_alt_outlined,
                    size: sp(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
