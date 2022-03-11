import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../cores/utils/sizer_utils.dart';

class FoodHomeHeaderWidget extends StatelessWidget {
  const FoodHomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.menu, size: sp(20), color: kcIconGrey),
            TextWidget('Fast food',
                fontSize: sp(20), fontWeight: FontWeight.w500),
            Icon(CupertinoIcons.bell, size: sp(20), color: kcIconGrey),
          ],
        ),
        verticalSpace(20),
        Container(
          padding: EdgeInsets.only(left: sp(5)),
          height: sp(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sp(5)),
            color: kcWhite,
          ),
          child: Row(
            children: <Widget>[
              Icon(CupertinoIcons.search, size: sp(20), color: kcIconGrey),
              horizontalSpace(5),
              TextWidget(
                'Search for food',
                fontSize: sp(15),
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        )
      ],
    );
  }
}
