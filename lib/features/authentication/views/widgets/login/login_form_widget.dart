import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/custom_button.dart';
import 'package:jolobbi_app/cores/components/custom_textfiled.dart';
import 'package:jolobbi_app/features/authentication/cubits/login_cubit/login_cubit.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';
import '../../../models/login_model.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget(
            'Login to your account',
            fontWeight: FontWeight.w600,
            fontSize: sp(14),
          ),
          TextWidget(
            'Enter your email and password to access your account',
            fontWeight: FontWeight.w300,
            fontSize: sp(11),
          ),
          verticalSpace(20),
          CustomTextField(
            hintText: 'Email',
            onChanged: context.read<LoginCubit>().onEmailChange,
            validator: emailValidator,
          ),
          verticalSpace(),
          CustomTextField(
            hintText: 'Password',
            isPassword: true,
            onChanged: context.read<LoginCubit>().onPasswordChange,
            validator: passwordValidator,
          ),
          verticalSpace(40),
          BlocBuilder<LoginCubit, LoginModel>(
            builder: (context, state) {
              if (state.loginStatus == LoginStatus.busy) {
                return const CustomButton.loading();
              }

              return CustomButton(
                text: 'Login',
                onTap: context.read<LoginCubit>().onSubmitFom,
              );
            },
          ),
        ],
      ),
    );
  }
}
