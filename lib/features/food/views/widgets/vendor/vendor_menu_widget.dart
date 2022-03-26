import 'package:flutter/material.dart';
import 'package:jolobbi_app/features/food/views/widgets/vendor/snack_menu_list_view_widget.dart';

import 'drinks_menu_list_view_widget.dart';
import 'food_menu_list_view_widget.dart';

class VendorMenuWidget extends StatelessWidget {
  const VendorMenuWidget(this.vendorId, {Key? key}) : super(key: key);

  final String vendorId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          const TabBar(
            tabs: [Tab(text: 'Food'), Tab(text: 'Drinks'), Tab(text: 'Snacks')],
          ),
          Expanded(
            child: TabBarView(
              children: [
                FoodMenuItemListView(vendorId),
                DrinkMenuItemListView(vendorId),
                SnackMenuItemListView(vendorId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
