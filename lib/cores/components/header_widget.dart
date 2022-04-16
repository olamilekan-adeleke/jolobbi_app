import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/search_bar_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../features/cart/views/widgets/cart_icon_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
    this.title, {
    Key? key,
    this.onTap,
    this.showSearchWidget = true,
  }) : super(key: key);

  final Function()? onTap;
  final String title;
  final bool showSearchWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: onTap ?? () {},
              child: Icon(
                Icons.menu,
                size: sp(20),
                color: kcIconGrey,
              ),
            ),
            const Spacer(),
            TextWidget(
              title,
              fontSize: sp(20),
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            const CartIconWidget(),
            horizontalSpace(4),
            Icon(CupertinoIcons.bell, size: sp(20), color: kcIconGrey),
          ],
        ),
        showSearchWidget
            ? Column(
                children: [
                  verticalSpace(20),
                  const SearchBarWidget(),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
