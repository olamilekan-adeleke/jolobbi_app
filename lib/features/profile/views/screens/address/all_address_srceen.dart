import 'package:flutter/material.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import 'add_address_page.dart';

class AllAddressScreen extends StatelessWidget {
  const AllAddressScreen({Key? key}) : super(key: key);

  static const String route = '/all-address-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.instance.navigateTo(AddAddressScreen.route);
        },
        child: const Icon(Icons.add, color: kcWhite),
      ),
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Address'),
          verticalSpace(30),

          //
          verticalSpace(100),
          Icon(
            Icons.location_on_outlined,
            color: kcIconGrey.withOpacity(0.5),
            size: sp(80),
          ),
          TextWidget(
            'opps, it seems you have not added any delivery address, Click on the button below to add an address',
            fontSize: sp(12),
            textColor: kcSubTextColor,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
