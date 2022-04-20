import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jolobbi_app/cores/components/loading_indicator.dart';
import 'package:jolobbi_app/cores/utils/currency_formater.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/error_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/datetime_helper.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/transaction_history_cubit.dart';
import '../../enum/wallet_enum.dart';
import '../../model/transaction_history/transaction_history_data_model.dart';
import '../../model/transaction_history/transaction_history_state_model.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          'Recent Transactions',
          fontSize: sp(16),
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(20),
        BlocBuilder<TransactionHistoryCubit, TransactionHistoryStateModel>(
          builder: (context, state) {
            if (state.status == WalletStatus.busy) {
              return const CustomLoadingIndicatorWidget();
            } else if (state.status == WalletStatus.error) {
              return CustomErrorWidget(
                message: state.errorText,
                callback: () {
                  context
                      .read<TransactionHistoryCubit>()
                      .getUserTransactionHistory();
                },
              );
            }

            return ListView.separated(
              itemCount: state.transactionHistory.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, int index) {
                final TransactionHistoryDataModel transactionHistory =
                    state.transactionHistory[index];
                return TransactionItemWidget(transactionHistory);
              },
            );
          },
        ),
      ],
    );
  }
}

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget(this.transactionHistory, {Key? key})
      : super(key: key);

  final TransactionHistoryDataModel transactionHistory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: sp(35),
          width: sp(35),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kcPrimaryColor,
          ),
          child: Center(child: _iconWidget(transactionHistory.type)),
        ),
        horizontalSpace(5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                transactionHistory.description,
                fontSize: sp(15),
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                DateTimeHelper.formatDate(
                    transactionHistory.timestamp.toDate()),
                fontSize: sp(11),
                fontWeight: FontWeight.w200,
                textColor: kcSubTextColor,
              ),
            ],
          ),
        ),
        TextWidget(
          'NGN ${currencyFormatter(5200, addDecimal: false)}',
          fontSize: sp(14),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _iconWidget(String type) {
    return SvgPicture.asset(
      'assets/icons/bank_icon.svg',
      color: kcWhite,
      height: sp(20),
      width: sp(20),
    );
  }
}
