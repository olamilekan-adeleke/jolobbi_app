import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/header_widget.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';
import 'package:jolobbi_app/features/wallet/views/widgets/recent_transaction_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../cubit/wallet_cubit.dart';
import '../widgets/wallet_balance_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static const String route = '/wallet';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<WalletCubit>().getWalletBalance();
      },
      child: CustomScaffoldWidget(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<WalletCubit>().getWalletBalance();
          },
          child: Column(
            children: <Widget>[
              verticalSpace(),
              HeaderWidget('Wallet', showSearchWidget: false, onTap: () {}),
              verticalSpace(20),
              const WalletBalanceWidget(),
              verticalSpace(40),
              const RecentTransactionWidget(),
              verticalSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
