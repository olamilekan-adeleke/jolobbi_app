import 'package:flutter/material.dart';
import 'package:jolobbi_app/cores/components/header_widget.dart';
import 'package:jolobbi_app/cores/utils/sizer_utils.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../widgets/wallet_balance_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static const String route = '/wallet';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Column(
        children: <Widget>[
          verticalSpace(),
          HeaderWidget('Wallet', showSearchWidget: false, onTap: () {}),
          vr
          const WalletBalanceWidget(),
        ],
      ),
    );
  }
}
