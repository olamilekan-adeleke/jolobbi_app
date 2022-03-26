import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/features/food/views/widgets/drawer/drawer_item_wigdet.dart';

import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/drawer/drawer_user_profile.dart';

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
            onTap: () {},
          ),
          verticalSpace(20),
          DrawerItemWidget(
            icon: Icons.store_mall_directory_outlined,
            title: 'See All Vendor',
            onTap: () {},
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
