import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/food_home_header_widget.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  static const String route = '/food-home';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        body: Column(
      children: <Widget>[
        verticalSpace(),
        const FoodHomeHeaderWidget(),
      ],
    ));
  }
}
