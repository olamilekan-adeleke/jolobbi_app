import 'package:flutter/material.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/validator.dart';

class SendFundToVendorFormWidget extends StatelessWidget {
  const SendFundToVendorFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
            hintText: 'Vendor Tag',
            onChanged: (_) {},
            validator: nameValidator,
            textInputType: TextInputType.name,
            fillColor: kcWhite,
          ),
          verticalSpace(),
          CustomTextField(
            hintText: 'NGN 2000',
            onChanged: (_) {},
            validator: amountValidator,
            textInputType: TextInputType.number,
            fillColor: kcWhite,
          ),
          verticalSpace(10),
          Row(
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
          const Spacer(),
          CustomButton(
            text: 'Send',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
