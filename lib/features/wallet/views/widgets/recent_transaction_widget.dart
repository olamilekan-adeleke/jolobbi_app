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

class RecentTransactionWidget extends StatefulWidget {
  const RecentTransactionWidget({Key? key}) : super(key: key);

  @override
  State<RecentTransactionWidget> createState() =>
      _RecentTransactionWidgetState();
}

class _RecentTransactionWidgetState extends State<RecentTransactionWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context
          .read<TransactionHistoryCubit>()
          .initScrollListener(scrollController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
              return const Center(child: CustomLoadingIndicatorWidget());
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

            return Flexible(
              child: Stack(
                children: [
                  ListView.separated(
                    itemCount: state.transactionHistory.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, int index) {
                      final TransactionHistoryDataModel transactionHistory =
                          state.transactionHistory[index];
                      return TransactionItemWidget(transactionHistory);
                    },
                  ),
                  BlocBuilder<TransactionHistoryCubit,
                      TransactionHistoryStateModel>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: state.status == WalletStatus.moreBusy
                            ? const LoadingMoreWidget()
                            : Container(),
                      );
                    },
                  ),
                ],
              ),
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
          height: sp(30),
          width: sp(30),
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
                fontSize: sp(14),
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.left,
              ),
              TextWidget(
                DateTimeHelper.formatDate(
                  transactionHistory.timestamp.toDate(),
                ),
                fontSize: sp(11),
                fontWeight: FontWeight.w200,
                textColor: kcSubTextColor,
              ),
            ],
          ),
        ),
        horizontalSpace(15),
        Align(
          alignment: Alignment.topCenter,
          child: TextWidget(
            'NGN ${currencyFormatter(transactionHistory.amount, addDecimal: false)}',
            fontSize: sp(14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _iconWidget(String type) {
    if (type == 'fund_transfer') {
      return SvgPicture.asset(
        'assets/icons/send.svg',
        color: kcWhite,
        height: sp(15),
        width: sp(15),
      );
    } else {
      return SvgPicture.asset(
        'assets/icons/wallet.svg',
        color: kcWhite,
        height: sp(15),
        width: sp(15),
      );
    }
  }
}
