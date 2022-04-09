import 'package:flutter/material.dart';

class BottomSheetHelper {
  static void show({required BuildContext context, required Widget child}) {
    showModalBottomSheet(context: context, builder: (_) => child);
  }
}
