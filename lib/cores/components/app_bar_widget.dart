import 'package:flutter/material.dart';

import '../navigator/app_router.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
    this.title, {
    Key? key,
    this.showBackButton = true,
    this.trilling,
  }) : super(key: key);

  final String title;
  final bool showBackButton;
  final Widget? trilling;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (showBackButton)
          GestureDetector(
            onTap: AppRouter.instance.goBack,
            child: Icon(Icons.arrow_back_ios_rounded, size: sp(10)),
          )
        else
          Container(),
        TextWidget(title, fontSize: sp(21)),
        trilling ?? Container(),
      ],
    );
  }
}
