import 'package:flutter/cupertino.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import 'cart_icon_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(),
        const AppBarWidget('My Cart', trilling: CartIconWidget()),
        verticalSpace(),
        verticalSpace(50),
        Icon(CupertinoIcons.cube_box, size: sp(100), color: kcIconGrey),
        verticalSpace(),
        TextWidget(
          'You are yet to add an item to your cart',
          fontSize: sp(15),
          fontWeight: FontWeight.w300,
        )
      ],
    );
  }
}
