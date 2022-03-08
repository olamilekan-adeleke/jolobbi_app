import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/views/screens/login_screen.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../food/views/screen/food_home_page.dart';
import '../../enum/auth_enum.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticatedStateCubit, AuthenticatedStatus>(
      builder: (context, state) {
        switch (state) {
          case AuthenticatedStatus.authenticated:
            return const FoodHomePage();
          case AuthenticatedStatus.unauthenticated:
            return const LoginScreen();
          default:
            return const LoginScreen();
        }
      },
    );
  }
}
