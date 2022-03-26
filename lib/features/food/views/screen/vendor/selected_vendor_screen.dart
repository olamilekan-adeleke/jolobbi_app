import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class SelectedVendorScreen extends StatelessWidget {
  const SelectedVendorScreen({Key? key}) : super(key: key);

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
              child: const CustomImageWidget(
                imageUrl: 'assets/images/food_3.png',
                imageTypes: ImageTypes.asset,
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
              child: const VendorDetailsBodyWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class VendorDetailsBodyWidget extends StatelessWidget {
  const VendorDetailsBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        children: <Widget>[
          const FoodItemHeaderWidget(),
          verticalSpace(),
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
                  Flexible(
                    child: TabBarView(
                      children: [
                        Container(),
                        Container(),
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
  const FoodItemHeaderWidget({Key? key}) : super(key: key);

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
                'Vendor name',
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
                    'Tanke, Ilorin',
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
