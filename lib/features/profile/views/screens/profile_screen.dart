import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/app_router.dart';
import '../widgets/profile_header_widget.dart';
import 'address/all_address_srceen.dart';
import 'update_profile_screen.dart';
import 'wallet_pin/update_wallet_pin_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String route = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sp(15)),
            child: const AppBarWidget('Profile'),
          ),
          verticalSpace(30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sp(15)),
            child: const ProfileHeaderWidget(),
          ),
          verticalSpace(40),
          _profileItem(
            CupertinoIcons.person,
            'My Account',
            onTap: () {
              AppRouter.instance.navigateTo(UpdateProfileScreen.route);
            },
          ),
          verticalSpace(5),
          _profileItem(Icons.find_in_page_outlined, 'Order History'),
          verticalSpace(5),
          _profileItem(
            Icons.location_on_outlined,
            'Address',
            onTap: () {
              AppRouter.instance.navigateTo(AllAddressScreen.route);
            },
          ),
          verticalSpace(5),
          _profileItem(CupertinoIcons.lock_fill, 'Change password'),
          verticalSpace(5),
          _profileItem(
            CupertinoIcons.lock_fill,
            'Change Wallet Pin',
            onTap: () {
              AppRouter.instance.navigateTo(UpdateWalletPinPage.route);
            },
          ),
          verticalSpace(5),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(5)),
        color: kcWhite,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 22,
              backgroundColor: kcPrimaryColor,
              child: Icon(icon, size: sp(15), color: kcWhite),
            ),
            horizontalSpace(),
            TextWidget(title, fontSize: sp(15)),
          ],
        ),
      ),
    );
  }
}
