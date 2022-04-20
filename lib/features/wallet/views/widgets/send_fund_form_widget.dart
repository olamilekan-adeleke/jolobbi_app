import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/validator.dart';
import '../../cubit/send_fund_cubit.dart';
import '../../enum/wallet_enum.dart';
import '../../model/fund/send_fund_state_model.dart';
import '../screens/scan_qr_code_screen.dart';

class SendFundToVendorFormWidget extends StatelessWidget {
  const SendFundToVendorFormWidget({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController vendorTag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SendFundCubit sendFundCubit = context.read<SendFundCubit>();

    return Flexible(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextWidget(
              'Send Money To Any Vendor',
              fontSize: sp(18),
              fontWeight: FontWeight.w300,
            ),
            verticalSpace(5),
            TextWidget(
              'You can quickly send fund to any vendor by using there username or by scanning there QR-Code ',
              fontSize: sp(12),
              textColor: kcSubTextColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
            ),
            verticalSpace(40),
            CustomTextField(
              textEditingController: vendorTag,
              hintText: 'Vendor Tag',
              onChanged: sendFundCubit.onVendorTagChange,
              validator: nameValidator,
              textInputType: TextInputType.name,
              fillColor: kcWhite,
            ),
            verticalSpace(),
            CustomTextField(
              hintText: 'NGN 2000',
              onChanged: sendFundCubit.onAmountChange,
              validator: amountValidator,
              textInputType: TextInputType.number,
              fillColor: kcWhite,
            ),
            verticalSpace(10),
            GestureDetector(
              onTap: () async {
                final String? tag =
                    await AppRouter.instance.navigate(const ScanQRCodeScreen());

                if (tag == null) return;

                vendorTag.text = tag;
                sendFundCubit.onVendorTagChange(tag);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner_outlined,
                    size: sp(15),
                    color: kcPrimaryColor,
                  ),
                  horizontalSpace(5),
                  TextWidget(
                    'Tap To Scan QR-Code',
                    fontSize: sp(12),
                    textColor: kcPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            const Spacer(),
            BlocBuilder<SendFundCubit, SendFundStateModel>(
              builder: (context, state) {
                if (state.status == WalletStatus.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Send',
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      sendFundCubit.makeTransfer();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
