import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../cubits/auth_state_cubit.dart';
import '../../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../enum/auth_enum.dart';
import '../../models/sign_up_model.dart';
import '../widgets/sign_up/sign_up_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String route = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpModel>(
      listener: (context, state) {
        if (state.signUpStatus == SignUpStatus.success) {
          context
              .read<AuthenticatedStateCubit>()
              .updateState(AuthenticatedStatus.authenticated);

          log(context.read<AuthenticatedStateCubit>().authStatus.toString());
        } else if (state.signUpStatus == SignUpStatus.error) {
          String error = context.read<SignUpCubit>().state.exceptionText;

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
                child: const SignUpFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
