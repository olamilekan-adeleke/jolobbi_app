import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';
import '../../../cubits/login_cubit/login_cubit.dart';
import '../../../enum/auth_enum.dart';
import '../../../models/login_model.dart';
import '../../screens/auth_state_screen.dart';
import '../../screens/forgot_password.dart';

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
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(),
          CustomTextField(
            hintText: 'Password',
            isPassword: true,
            onChanged: context.read<LoginCubit>().onPasswordChange,
            validator: passwordValidator,
            textInputType: TextInputType.visiblePassword,
          ),
          verticalSpace(5),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: TextWidget(
                'Forgot Password?',
                fontWeight: FontWeight.w500,
                fontSize: sp(11),
              ),
            ),
          ),
          verticalSpace(),
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
          verticalSpace(20),
          BlocBuilder<LoginCubit, LoginModel>(
            builder: (context, state) {
              if (state.loginStatus == LoginStatus.busy) {
                return Container();
              }

              return Center(
                child: GestureDetector(
                  onTap: context.read<LoginCubit>().biometricLogin,
                  child: SizedBox(
                    height: sp(20),
                    width: sp(20),
                    child: const CustomImageWidget(
                      imageUrl: 'assets/images/thumb_print_icon.svg',
                      imageTypes: ImageTypes.svg,
                    ),
                  ),
                ),
              );
            },
          ),
          verticalSpace(20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const AuthStateScreen(
                    isLoginScreen: false,
                  ),
                ),
              );
            },
            child: Center(
              child: TextWidget(
                'New Here? Click To Create An Account',
                fontWeight: FontWeight.w500,
                fontSize: sp(11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
