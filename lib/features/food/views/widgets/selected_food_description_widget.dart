import 'package:flutter/material.dart';
import 'package:jolobbi_app/features/food/views/widgets/food_item_add_on_widget.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../model/food_item_data_model.dart';
import 'selected_food_extra_widget.dart';

class SelectedFoodDescriptionAndAddonWidget extends StatelessWidget {
  const SelectedFoodDescriptionAndAddonWidget(
    this.foodItem, {
    Key? key,
  }) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(),
        TextWidget(
          foodItem.description,
          fontSize: sp(12),
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children:  <Widget>[
                const TabBar(
                  tabs: [Tab(text: 'Extras'), Tab(text: 'Add On')],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SelectedFoodItemExtraListViewWidget(foodItem.extras!),
                      const FoodItemAddOnListViewWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
