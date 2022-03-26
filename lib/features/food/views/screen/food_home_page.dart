import 'package:flutter/material.dart';
import 'package:jolobbi_app/features/home/views/screens/home_drawer_screen.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/food_home_header_widget.dart';
import '../widgets/food_item_list_view_widget.dart';
import '../widgets/popular_food_vender_widget.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  static const String route = '/food-home';
  static final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      scaffoldKey: _key,
      useSingleScroll: false,
      drawer: const Drawer(child: HomeDrawerWidget()),
      body: Column(
        children: <Widget>[
          verticalSpace(),
          FoodHomeHeaderWidget(onTap: _key.currentState?.openDrawer),
          verticalSpace(),
          const PopularFoodVendorWidget(),
          verticalSpace(5),
          const FoodItemListViewWidget(),
        ],
      ),
    );
  }
}
