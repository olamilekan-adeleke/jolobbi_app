import 'package:flutter/material.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../widgets/vendor/vendor_item_list_tile.dart';

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
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, int index) {
                return const VendorItemListTileWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
