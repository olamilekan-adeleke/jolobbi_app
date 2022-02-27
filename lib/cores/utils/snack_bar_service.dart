import 'package:jolobbi_app/cores/components/custom_text_widget.dart';
import 'package:jolobbi_app/cores/constants/color.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final snackBar = SnackBar(
      content: TextWidget(message, textColor: kcWhite),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () => hideSnackBar(context),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final snackBar = SnackBar(
      content: TextWidget(message, textColor: kcWhite),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () => hideSnackBar(context),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarningSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final snackBar = SnackBar(
      content: TextWidget(message, textColor: kcWhite),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: Colors.grey.shade800,
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () => hideSnackBar(context),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void hideSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
