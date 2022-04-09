import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/search_bar_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';

class FoodHomeHeaderWidget extends StatelessWidget {
  const FoodHomeHeaderWidget({Key? key, this.onTap}) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: onTap ?? () {},
              child: Icon(
                Icons.menu,
                size: sp(20),
                color: kcIconGrey,
              ),
            ),
            TextWidget(
              'Fast food',
              fontSize: sp(20),
              fontWeight: FontWeight.w500,
            ),
            // Icon(CupertinoIcons.bell, size: sp(20), color: kcIconGrey),
            Icon(CupertinoIcons.bell, size: sp(20), color: kcIconGrey),
          ],
        ),
        verticalSpace(20),
        const SearchBarWidget(),
      ],
    );
  }
}
