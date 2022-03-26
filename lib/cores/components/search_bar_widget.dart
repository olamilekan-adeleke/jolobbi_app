import 'package:flutter/cupertino.dart';

import '../constants/color.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key, this.title, this.onTap}) : super(key: key);

  final String? title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
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
              title ?? 'Search for food',
              fontSize: sp(15),
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}
