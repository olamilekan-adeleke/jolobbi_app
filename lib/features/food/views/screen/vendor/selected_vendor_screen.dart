import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../model/food_vendor_data_model.dart';
import '../../widgets/vendor/vendor_about_widget.dart';
import '../../widgets/vendor/vendor_menu_widget.dart';

class SelectedVendorScreen extends StatelessWidget {
  const SelectedVendorScreen(this.foodVendor, {Key? key}) : super(key: key);

  final FoodVendorDataModel foodVendor;

  static const String route = '/selected-vendor-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      usePadding: false,
      useSafeArea: false,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: sh(35),
              width: double.infinity,
              child: CustomImageWidget(
                imageUrl: foodVendor.image,
                imageTypes: ImageTypes.network,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: sh(68),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sp(10)),
                  topRight: Radius.circular(sp(10)),
                ),
              ),
              child: VendorDetailsBodyWidget(foodVendor),
            ),
          ),
        ],
      ),
    );
  }
}

class VendorDetailsBodyWidget extends StatelessWidget {
  const VendorDetailsBodyWidget(this.foodVendor, {Key? key}) : super(key: key);

  final FoodVendorDataModel foodVendor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sp(15)),
      child: Column(
        children: <Widget>[
          verticalSpace(),
          FoodItemHeaderWidget(foodVendor),
          verticalSpace(4),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  const TabBar(
                    tabs: [
                      Tab(text: 'Menu'),
                      Tab(text: 'About'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        VendorMenuWidget(foodVendor.id),
                        VendorAboutWidget(foodVendor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemHeaderWidget extends StatelessWidget {
  const FoodItemHeaderWidget(this.foodVendor, {Key? key}) : super(key: key);

  final FoodVendorDataModel foodVendor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                foodVendor.name,
                fontSize: sp(18),
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    size: sp(15),
                    color: kcPrimaryColor,
                  ),
                  TextWidget(
                    foodVendor.location.locationName,
                    fontSize: sp(14),
                    fontWeight: FontWeight.w300,
                    textColor: kcIconGrey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(Icons.star_rate, size: sp(15), color: kcPrimaryColor),
            Icon(Icons.star_rate, size: sp(15), color: kcPrimaryColor),
            Icon(Icons.star_rate, size: sp(15), color: kcPrimaryColor),
            Icon(Icons.star_rate, size: sp(15), color: kcPrimaryColor),
            Icon(Icons.star_rate, size: sp(15), color: kcPrimaryColor),
          ],
        ),
      ],
    );
  }
}
