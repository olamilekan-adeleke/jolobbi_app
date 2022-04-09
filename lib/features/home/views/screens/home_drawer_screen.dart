import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../food/views/screen/favorite/favorite_food_screen.dart';
import '../../../food/views/screen/vendor/all_food_vendor_screen.dart';
import '../../../profile/views/screens/profile_screen.dart';
import '../../../wallet/views/screens/wallet_screen.dart';
import '../widget/drawer/drawer_item_wigdet.dart';
import '../widget/drawer/drawer_user_profile.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: sp(10), vertical: sp(25)),
      child: Column(
        children: <Widget>[
          const DrawerUserProfileWidget(),
          verticalSpace(40),
          DrawerItemWidget(
            icon: CupertinoIcons.person,
            title: 'Profile',
            onTap: () {
              AppRouter.instance.popAndNavigateTo(ProfileScreen.route);
            },
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.favorite,
            title: 'Wallet',
            onTap: () {
              AppRouter.instance.popAndNavigateTo(WalletScreen.route);
            },
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.favorite,
            title: 'Favorite',
            onTap: () {
              AppRouter.instance.popAndNavigateTo(FavoriteScreen.route);
            },
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.store_mall_directory_outlined,
            title: 'See All Vendor',
            onTap: () {
              AppRouter.instance.popAndNavigateTo(AllFoodVendorScreen.route);
            },
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.find_in_page_outlined,
            title: 'Order History',
            onTap: () {},
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.location_on_outlined,
            title: 'Track Order',
            onTap: () {},
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.info_outline_rounded,
            title: 'Help',
            onTap: () {},
          ),
          const Spacer(),
          DrawerItemWidget(
            icon: Icons.exit_to_app,
            title: 'Logout',
            onTap: () {},
          ),
          // verticalSpace(40),
        ],
      ),
    );
  }
}
