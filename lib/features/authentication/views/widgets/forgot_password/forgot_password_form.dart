import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';
import '../../../cubits/forgot_password/forgot_password_cubit.dart';
import '../../../enum/auth_enum.dart';
import '../../../models/forgot_password_model.dart';

class ForgotFormWidget extends StatelessWidget {
  const ForgotFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget(
            'Forgot Password',
            fontWeight: FontWeight.w600,
            fontSize: sp(14),
          ),
          TextWidget(
            'Enter your email address and a confirmation link will be sent to the email address if an account for it was found ',
            fontWeight: FontWeight.w300,
            fontSize: sp(11),
          ),
          verticalSpace(20),
          CustomTextField(
            hintText: 'Email',
            onChanged: context.read<ForgotPasswordCubit>().onEmailChange,
            validator: emailValidator,
          ),
          verticalSpace(),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordModel>(
            builder: (context, state) {
              if (state.forgotPasswordStatus == ForgotPasswordStatus.busy) {
                return const CustomButton.loading();
              }

              return CustomButton(
                text: 'Submit',
                onTap: context.read<ForgotPasswordCubit>().onSubmitFom,
              );
            },
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
