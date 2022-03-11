import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';
import '../utils/sizer_utils.dart';

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const TextWidget('Page Not Found'),
        ),
        body: Center(
          child: TextWidget('ERROR: Route not found', fontSize: sp(20)),
        ),
      );
    },
  );
}
