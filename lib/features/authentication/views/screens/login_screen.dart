import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Text('login screen'),
    );
  }
}
