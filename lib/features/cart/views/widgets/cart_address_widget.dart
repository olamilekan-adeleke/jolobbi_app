import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/utils/bottom_sheet_helper.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../profile/model/user_profile_data_model.dart';
import '../../../profile/views/widgets/address/select_address_widget.dart';
import '../../cubit/order_cubit_state.dart';
import '../../model/order_details_state_model.dart';

class CartAddressWidget extends StatelessWidget {
  const CartAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final AddressModel? address = await BottomSheetHelper.show(
          context: context,
          child: const BottomSheetSelectAddressWidget(),
        );

        log('$address');

        if (address == null) return;

        context.read<AddOrderCubit>().onAddressChange(address);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sp(5), vertical: sp(8)),
          child: SizedBox(
            height: sp(65),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: sp(60),
                  width: sp(75),
                  child: const CustomImageWidget(
                    imageTypes: ImageTypes.asset,
                    imageUrl: 'assets/images/map.png',
                  ),
                ),
                horizontalSpace(),
                BlocBuilder<AddOrderCubit, OrderDetailsStateModel>(
                  builder: (context, state) {
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            state.address?.location ?? 'Select Address',
                            fontSize: sp(14),
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextWidget(
                            state.address?.location ??
                                'Tap to select your delivery address',
                            fontSize: sp(12),
                            fontWeight: FontWeight.w300,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                horizontalSpace(5),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit_location_alt_outlined,
                    size: sp(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
