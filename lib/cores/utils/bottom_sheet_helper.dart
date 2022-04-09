import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'sizer_utils.dart';

class BottomSheetHelper {
  static void show({required BuildContext context, required Widget child}) {
    showModalBottomSheet(
      backgroundColor: Colors.black.withOpacity(0.02),
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sp(15)),
            topRight: Radius.circular(sp(15)),
          ),
        ),
        child: child,
      ),
    );
  }
}
