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
        _AddOnAndExtraWidget(foodItem: foodItem),
      ],
    );
  }
}

class _AddOnAndExtraWidget extends StatelessWidget {
  const _AddOnAndExtraWidget({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    if (foodItem.addOn == null && foodItem.extras == null) {
      return Container();
    }

    if (foodItem.addOn == null) {
      return Expanded(
        child: DefaultTabController(
          length: 1,
          child: Column(
            children: <Widget>[
              const TabBar(
                tabs: [Tab(text: 'Extras')],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SelectedFoodItemExtraListViewWidget(foodItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (foodItem.extras == null) {
      return Expanded(
        child: DefaultTabController(
          length: 1,
          child: Column(
            children: <Widget>[
              const TabBar(
                tabs: [Tab(text: 'Add on')],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FoodItemAddOnListViewWidget(foodItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            const TabBar(
              tabs: [Tab(text: 'Extras'), Tab(text: 'Add On')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SelectedFoodItemExtraListViewWidget(foodItem),
                  FoodItemAddOnListViewWidget(foodItem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
