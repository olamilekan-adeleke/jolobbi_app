import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../model/food_vendor_data_model.dart';

class VendorAboutWidget extends StatelessWidget {
  const VendorAboutWidget(this.foodVendor, {Key? key}) : super(key: key);

  final FoodVendorDataModel foodVendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(30),
        aboutItem(
          'Location Address',
          Row(
            children: <Widget>[
              Icon(Icons.location_on, size: sp(15), color: kcPrimaryColor),
              horizontalSpace(),
              TextWidget(
                foodVendor.location.locationName,
                fontSize: sp(14),
              ),
            ],
          ),
        ),
        verticalSpace(),
        aboutItem(
          'Opening Hours',
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.access_time_filled_outlined,
                size: sp(15),
                color: kcPrimaryColor,
              ),
              horizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Monday - Saturday',
                    fontSize: sp(14),
                  ),
                  TextWidget(
                    '09:00 AM - 08:30 PM',
                    fontSize: sp(14),
                  ),
                ],
              ),
            ],
          ),
        ),
        verticalSpace(),
        aboutItem(
          'Contact',
          Row(
            children: <Widget>[
              Icon(Icons.phone, size: sp(15), color: kcPrimaryColor),
              horizontalSpace(),
              TextWidget(
                foodVendor.contact.number,
                fontSize: sp(14),
              ),
            ],
          ),
        ),
        verticalSpace(),
        aboutItem(
          'Email',
          Row(
            children: <Widget>[
              Icon(Icons.email, size: sp(15), color: kcPrimaryColor),
              horizontalSpace(),
              TextWidget(
                foodVendor.contact.email,
                fontSize: sp(14),
              ),
            ],
          ),
        ),
        verticalSpace(),
      ],
    );
  }

  Column aboutItem(String heading, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          heading,
          fontSize: sp(14),
          fontWeight: FontWeight.w500,
          textColor: kcIconGrey,
        ),
        verticalSpace(5),
        child,
      ],
    );
  }
}
