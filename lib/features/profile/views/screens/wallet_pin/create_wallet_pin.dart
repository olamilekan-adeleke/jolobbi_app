import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/constants/color.dart';
import 'package:jolobbi_app/cores/navigator/app_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/snack_bar_service.dart';
import '../../../cubit/wallet_pin/update_wallet_pin_cubit.dart';
import '../../../enum/profile_enum.dart';
import '../../../model/wallet_pin/update_wallet_pin_state_model.dart';

class CreateWalletPinPage extends StatelessWidget {
  const CreateWalletPinPage({Key? key}) : super(key: key);

  static const String route = '/create-wallet-pin';

  @override
  Widget build(BuildContext context) {
    final UpdateWalletPinCubit updateProfileCubit =
        context.read<UpdateWalletPinCubit>();

    return BlocListener<UpdateWalletPinCubit, UpdateWalletPinStateModel>(
      listener: (context, state) {
        if (state.status == UpdateWalletPinStatus.error) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.errorText,
          );
        } else if (state.status == UpdateWalletPinStatus.success) {
          AppRouter.instance.goBack(true);

          SnackBarService.showSuccessSnackBar(
            context: context,
            message: 'Wallet Pin Created Successfully!',
          );
        }
      },
      child: CustomScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          children: <Widget>[
            verticalSpace(),
            const AppBarWidget('Create Pin'),
            verticalSpace(30),
            TextWidget(
              'Create Your 4-digit Pin',
              fontSize: sp(18),
              fontWeight: FontWeight.w300,
            ),
            verticalSpace(5),
            TextWidget(
              'You\'ll use this pin for verification any time you want to make a transaction on your wallet 🔐, make sure only you know it 🤫',
              fontSize: sp(12),
              textColor: kcSubTextColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
            ),
            verticalSpace(40),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: true,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                inactiveColor: kcGrey600,
                selectedColor: kcTextColor,
              ),
              onChanged: updateProfileCubit.onPinChange,
            ),
            const Spacer(),
            BlocBuilder<UpdateWalletPinCubit, UpdateWalletPinStateModel>(
              builder: (context, state) {
                if (state.status == UpdateWalletPinStatus.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Create Pin',
                  onTap: updateProfileCubit.createWalletPin,
                );
              },
            ),
            verticalSpace(40),
          ],
        ),
      ),
    );
  }
}
