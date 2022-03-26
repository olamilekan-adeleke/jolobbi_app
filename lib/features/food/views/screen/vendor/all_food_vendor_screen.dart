import 'package:flutter/material.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/search_bar_widget.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../widgets/vendor/vendor_item_list_tile.dart';
import 'selected_vendor_screen.dart';

class AllFoodVendorScreen extends StatelessWidget {
  const AllFoodVendorScreen({Key? key}) : super(key: key);

  static const String route = '/all-food-vendor';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Vendors'),
          verticalSpace(),
          const SearchBarWidget(title: 'Search for vendor'),
          verticalSpace(),
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, int index) {
                return GestureDetector(
                  onTap: () {
                    AppRouter.instance.navigateTo(SelectedVendorScreen.route);
                  },
                  child: const VendorItemListTileWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
