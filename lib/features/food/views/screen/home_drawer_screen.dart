import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
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
        ],
      ),
    );
  }
}

