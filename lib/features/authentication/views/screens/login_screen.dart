import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/constants/color.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../cubits/auth_state_cubit.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../enum/auth_enum.dart';
import '../../models/login_model.dart';
import '../widgets/login/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(context.read<LoginCubit>().state.toMap().toString());

    return BlocListener<LoginCubit, LoginModel>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          context
              .read<AuthenticatedStateCubit>()
              .updateState(AuthenticatedStatus.authenticated);

          log('login');
          log(context.read<AuthenticatedStateCubit>().authStatus.toString());
        } else if (state.loginStatus == LoginStatus.error) {
          String error = context.read<LoginCubit>().state.exceptionText;

          SnackBarService.showErrorSnackBar(context: context, message: error);
        }
      },
      child: CustomScaffoldWidget(
        useSingleScroll: false,
        usePadding: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: kcPrimaryColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(sp(10)),
                    topRight: Radius.circular(sp(10)),
                  ),
                ),
                child: const LoginFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
