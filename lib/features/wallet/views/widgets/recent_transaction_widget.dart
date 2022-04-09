import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jolobbi_app/cores/utils/currency_formater.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';

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
        ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, int index) {
            return const TransactionItemWidget();
          },
        ),
      ],
    );
  }
}

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({Key? key}) : super(key: key);

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
          child: Center(child: _iconWidget()),
        ),
        horizontalSpace(5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Bank Transfer',
                fontSize: sp(15),
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                DateFormat('dd MMM, yyyy hh:mm a').format(DateTime.now()),
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

  Widget _iconWidget() {
    return SvgPicture.asset(
      'assets/icons/bank_icon.svg',
      color: kcWhite,
      height: sp(20),
      width: sp(20),
    );
  }
}
