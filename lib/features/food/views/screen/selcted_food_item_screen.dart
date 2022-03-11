import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';

class SelectedFoodItemWidget extends StatelessWidget {
  const SelectedFoodItemWidget({Key? key}) : super(key: key);

  static const String route = '/selected-food-item';

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
            ),
          ),
        ],
      ),
    );
  }
}
