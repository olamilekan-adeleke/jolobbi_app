import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import 'food_extra_widget.dart';

class FoodDescriptionAndAddonWidget extends StatelessWidget {
  const FoodDescriptionAndAddonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(),
        TextWidget(
          'The ITEM 7 jollof rice with chicken is rich in protein and its taste is very nutritious and experts and many food bloggers believe going for a price of #800 seems to be an absolute steal in the market today. \nHave a taste of this beauty today, Order now! ',
          fontSize: sp(12),
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                const TabBar(
                  tabs: [
                    Tab(text: 'Extras'),
                    Tab(text: 'Add On'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const FoodItemExtraListViewWidget(),
                      Center(child: TextWidget('Add On' * 5)),
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
