import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/views/screens/login_screen.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../enum/auth_enum.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: BlocBuilder<AuthenticatedStateCubit, AuthenticatedStatus>(
        builder: (context, state) {
          switch (state) {
            case AuthenticatedStatus.authenticated:
              // TODO: Handle this case.
              break;
            case AuthenticatedStatus.unauthenticated:
              return const LoginScreen();
          }
          return Container();
        },
      ),
    );
  }
}
