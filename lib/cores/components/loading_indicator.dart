import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../constants/color.dart';
import '../utils/sizer_utils.dart';

class CustomLoadingIndicatorWidget extends StatelessWidget {
  const CustomLoadingIndicatorWidget({
    Key? key,
    this.strokeWidth,
    this.value,
  }) : super(key: key);

  final double? strokeWidth;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CircularProgressIndicator.adaptive(
        // color: Colors.grey[200],
        backgroundColor: Colors.grey,
        strokeWidth: strokeWidth ?? 2.0,
        value: value,
      ),
    );
  }
}

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(10), vertical: sp(5)),
      margin: EdgeInsets.symmetric(vertical: sp(10)),
      decoration: BoxDecoration(
        color: kcGrey100,
        borderRadius: BorderRadius.circular(sp(3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget('Loading More', fontSize: sp(10)),
          horizontalSpace(5),
          const CupertinoActivityIndicator(radius: 8),
        ],
      ),
    );
  }
}
