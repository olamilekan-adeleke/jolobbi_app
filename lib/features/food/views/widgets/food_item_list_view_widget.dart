import 'package:flutter/material.dart';

import '../../../../cores/utils/sizer_utils.dart';
import 'food_item_list_view_tab_bar_widget.dart';
import 'food_item_widget.dart';

class FoodItemListViewWidget extends StatelessWidget {
  const FoodItemListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          const FoodItemListViewTabBarWidget(),
          verticalSpace(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, int index) {
                return const FoodItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}
