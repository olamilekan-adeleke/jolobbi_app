import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/navigator/app_router.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../cubit/send_fund_cubit.dart';
import '../../cubit/wallet_cubit.dart';
import '../../enum/wallet_enum.dart';
import '../../model/send_fund_state_model.dart';
import '../widgets/send_fund_form_widget.dart';

class SendFundToVendor extends StatelessWidget {
  const SendFundToVendor({Key? key}) : super(key: key);

  static const String route = '/send-fund';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendFundCubit, SendFundStateModel>(
      listener: (context, state) {
        if (state.status == WalletStatus.error) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.errorText,
          );
        }else if (state.status == WalletStatus.success) {
          AppRouter.instance.goBack();

          SnackBarService.showSuccessSnackBar(
            context: context,
            message: 'TransferWas Successful!',
          );

          context.read<WalletCubit>().getWalletBalance();
        }
      },
      child: CustomScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            verticalSpace(),
            const AppBarWidget('Send Fund'),
            verticalSpace(20),
            const SendFundToVendorFormWidget(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
