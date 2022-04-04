import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../food/views/screen/food_home_page.dart';
import '../../cubits/auth_state_cubit.dart';
import '../../enum/auth_enum.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key, this.isLoginScreen = true})
      : super(key: key);
  static const String route = '/';

  final bool isLoginScreen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticatedStateCubit, AuthenticatedStatus>(
      builder: (context, state) {
        return const FoodHomePage();
        // switch (state) {
        //   case AuthenticatedStatus.authenticated:
        //     return const FoodHomePage();
        //   case AuthenticatedStatus.unauthenticated:
        //     if (isLoginScreen) {
        //       return const LoginScreen();
        //     } else {
        //       return const SignUpScreen();
        //     }
        //   default:
        //     if (isLoginScreen) {
        //       return const LoginScreen();
        //     } else {
        //       return const SignUpScreen();
        //     }
        // }
      },
    );
  }
}
