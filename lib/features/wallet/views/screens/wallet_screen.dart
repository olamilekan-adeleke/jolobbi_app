import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/header_widget.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';
import 'package:jolobbi_app/features/wallet/views/widgets/recent_transaction_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../cubit/fund_wallet_cubit.dart';
import '../../cubit/transaction_history_cubit.dart';
import '../../cubit/wallet_cubit.dart';
import '../../enum/wallet_enum.dart';
import '../../model/fund/fund_wallet_state_model.dart';
import '../widgets/wallet_balance_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static const String route = '/wallet';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<WalletCubit>().getWalletBalance(),
          context.read<TransactionHistoryCubit>().getUserTransactionHistory(),
        ]);
      },
      child: BlocListener<FundWalletCubit, FundWalletStateModel>(
        listener: (context, state) {
          if (state.status == WalletStatus.error) {
            return SnackBarService.showErrorSnackBar(
              context: context,
              message: state.errorText,
            );
          } else if (state.status == WalletStatus.success) {
            context.read<WalletCubit>().getWalletBalance();

            return SnackBarService.showSuccessSnackBar(
              context: context,
              message: 'Transaction is been processed, '
                  'Your wallet will be funded soon!',
            );
          }
        },
        child: CustomScaffoldWidget(
          useSingleScroll: false,
          body: SizedBox(
            height: sh(98),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                verticalSpace(),
                HeaderWidget('Wallet', showSearchWidget: false, onTap: () {}),
                verticalSpace(20),
                const WalletBalanceWidget(),
                verticalSpace(20),
                const Expanded(child: RecentTransactionWidget()),
                verticalSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
