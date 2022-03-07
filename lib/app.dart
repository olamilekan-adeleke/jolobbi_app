import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import 'features/authentication/views/screens/auth_state_screen.dart';

class JolobbiApp extends StatelessWidget {
  const JolobbiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jolobbi Dev',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: kcPrimaryColor,
        errorColor: kcSuccessColor,
      ),
      home: const AuthStateScreen(),
    );
  }
}
