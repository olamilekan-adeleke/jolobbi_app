import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monnify_flutter_sdk/monnify_flutter_sdk.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';

import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../../profile/cubit/user_profile/profile_details_cubit.dart';
import '../../cubit/fund_wallet_cubit.dart';
import '../screens/flutter_wave_web_view.dart';

class FundWalletAmountWidget extends StatelessWidget {
  const FundWalletAmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: sp(5),
            width: sp(42),
            decoration: BoxDecoration(
              color: const Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(sp(25)),
            ),
          ),
        ),
        verticalSpace(30),
        TextWidget(
          'Enter Amount',
          fontSize: sp(14),
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(5),
        CustomTextField(
          hintText: 'NGN 1,000',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (String value) {
            context.read<FundWalletCubit>().onAmountChange(value);
          },
        ),
        verticalSpace(40),
        CustomButton(
          text: 'Proceed To Payment',
          onTap: () => _fund(context),
        ),
      ],
    );
  }

  void _fund(BuildContext context) async {
    final FundWalletCubit _fundWalletCubit = context.read<FundWalletCubit>();

    final ProfileDetailsCubit profileCubit =
        context.read<ProfileDetailsCubit>();

    if (_fundWalletCubit.state.amount.isEmpty) {
      return SnackBarService.showWarningSnackBar(
        context: context,
        message: 'Please Enter Amount!',
      );
    }

    if (profileCubit.state.userData == null) {
      // todo: log out user!

      return SnackBarService.showErrorSnackBar(
        context: context,
        message: 'User Data was not found!',
      );
    }

    TransactionResponse transactionResponse =
        await MonnifyFlutterSdk.initializePayment(
      Transaction(
        2000,
        "NGN",
        profileCubit.state.userData!.name,
        profileCubit.state.userData!.email,
        "jollobi-${DateTime.now().millisecondsSinceEpoch}",
        "Description of payment",
        metaData: {
          // TODO: add more metadata
          "ip": "196.168.45.22",
          "device": "mobile_flutter"
        },
        paymentMethods: [PaymentMethod.CARD, PaymentMethod.ACCOUNT_TRANSFER],
      ),
    );

    log(transactionResponse.toMap().toString());

    // if (paymentResponse == null) {
    //   AppRouter.instance.goBack();

    //   return SnackBarService.showWarningSnackBar(
    //     context: context,
    //     message: 'Opps, it seems like something went wrong!',
    //   );
    // }

    // // {status: successful, customer: {name: Jack The Ripper , email: teduvf@gmail.com, phone_number: 07052936789}, transaction_id: 3280243, tx_ref: jolobbi_food-9f61f1a0-b8cf-11ec-9613-e18c12f05117, flw_ref: FLW-M03K-df672cc4e6e41ea7cc1016820faff81a, currency: NGN, amount: 200}

    // _fundWalletCubit.fundWallet(paymentResponse['transaction_id']);
    // AppRouter.instance.goBack();
  }
}
