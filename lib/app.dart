import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/constants/color.dart';
import 'package:jolobbi_app/features/authentication/cubits/login_cubit/login_cubit.dart';
import 'package:jolobbi_app/features/authentication/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:sizer/sizer.dart';

import 'features/authentication/cubits/auth_state_cubit.dart';
import 'features/authentication/enum/auth_enum.dart';
import 'features/authentication/repository/login_repository.dart';
import 'features/authentication/repository/sign_up_repositry.dart';
import 'features/authentication/views/screens/auth_state_screen.dart';

class JolobbiApp extends StatelessWidget {
  const JolobbiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _BlocProviderHelper().blocList(context),
      child: Sizer(
        builder: (_, __, ___) {
          return MaterialApp(
            title: 'Jolobbi Dev',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              primaryColor: kcPrimaryColor,
              errorColor: kcErrorColor,
            ),
            home: const AuthStateScreen(),
          );
        },
      ),
    );
  }
}

class _BlocProviderHelper {
  static final LoginRepository loginRepository = LoginRepository();
  static final SignUpRepository signUpRepository = SignUpRepository();

  List<BlocProvider> blocList(BuildContext context) {
    return <BlocProvider>[
      BlocProvider<AuthenticatedStateCubit>(
        create: (_) => AuthenticatedStateCubit(
          authStatus: AuthenticatedStatus.unauthenticated,
        ),
        lazy: false,
      ),
      BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(loginRepository: loginRepository),
      ),
      BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(signUpRepository: signUpRepository),
      ),
    ];
  }
}
