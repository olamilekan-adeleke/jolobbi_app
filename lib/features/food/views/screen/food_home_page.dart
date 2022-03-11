import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/food_home_header_widget.dart';
import '../widgets/food_item_list_view_widget.dart';
import '../widgets/popular_food_vender_widget.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  static const String route = '/food-home';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const FoodHomeHeaderWidget(),
          verticalSpace(),
          const PopularFoodVendorWidget(),
          verticalSpace(5),
          const FoodItemListViewWidget(),
        ],
      ),
    );
  }
}
