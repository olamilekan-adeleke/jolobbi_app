import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';
import '../../../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../../enum/auth_enum.dart';
import '../../../models/sign_up_model.dart';
import '../../screens/auth_state_screen.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextWidget(
              'Create an account',
              fontWeight: FontWeight.w600,
              fontSize: sp(14),
            ),
            TextWidget(
              'Enter your details to create your account',
              fontWeight: FontWeight.w300,
              fontSize: sp(11),
            ),
            verticalSpace(20),
            CustomTextField(
              hintText: 'Name',
              onChanged: context.read<SignUpCubit>().onNameChange,
              validator: nameValidator,
            ),
            verticalSpace(),
            CustomTextField(
              hintText: 'Email',
              onChanged: context.read<SignUpCubit>().onEmailChange,
              validator: emailValidator,
            ),
            verticalSpace(),
            CustomTextField(
              hintText: 'Mobile Number',
              onChanged: context.read<SignUpCubit>().onEmailChange,
              validator: mobileValidator,
            ),
            verticalSpace(),
            CustomTextField(
              hintText: 'Password',
              isPassword: true,
              onChanged: context.read<SignUpCubit>().onPasswordChange,
              validator: passwordValidator,
            ),
            verticalSpace(),
            BlocBuilder<SignUpCubit, SignUpModel>(
              builder: (context, state) {
                if (state.signUpStatus == SignUpStatus.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Create Account',
                  onTap: context.read<SignUpCubit>().onSubmittedForm,
                );
              },
            ),
            verticalSpace(20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AuthStateScreen()),
                );
              },
              child: Center(
                child: TextWidget(
                  'Have An Account? Click To Login',
                  fontWeight: FontWeight.w500,
                  fontSize: sp(11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
