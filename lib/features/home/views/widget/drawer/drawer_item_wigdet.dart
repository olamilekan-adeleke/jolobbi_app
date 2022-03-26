import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Row(
        children: <Widget>[
          Icon(icon, size: sp(15), color: kcWhite),
          horizontalSpace(),
          TextWidget(
            title,
            fontSize: sp(15),
            fontWeight: FontWeight.w400,
            textColor: kcWhite,
          ),
        ],
      ),
    );
  }
}
