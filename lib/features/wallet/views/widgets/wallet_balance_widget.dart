import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../cubit/wallet_cubit.dart';
import '../../model/wallet_state_model.dart';

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: sp(140),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/wallet_background.png',
            width: double.infinity,
            height: sp(140),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                verticalSpace(),
                TextWidget(
                  'Wallet Balance',
                  fontSize: sp(15),
                  fontWeight: FontWeight.w200,
                  textColor: kcWhite,
                ),
                const Spacer(),
                BlocBuilder<WalletCubit, WalletStateModel>(
                  builder: (context, state) {
                    return TextWidget(
                      'NGN ${currencyFormatter(state.walletData?.cashBalance ?? 0)}',
                      fontSize: sp(25),
                      fontWeight: FontWeight.w700,
                      textColor: kcWhite,
                    );
                  },
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sp(20)),
                  child: CustomButton(
                    text: 'Fund Wallet',
                    textColor: kcTextColor,
                    color: kcWhite,
                    onTap: () {},
                  ),
                ),
                verticalSpace(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
