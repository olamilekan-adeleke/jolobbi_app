import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/address_cubit/update_address_cubit.dart';
import '../../../model/address/update_address_state_model.dart';
import '../../widgets/update_address/update_address_form_widget.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  static const String route = '/add-address-screen';

  @override
  Widget build(BuildContext context) {
    final UpdateAddressCubit updateAddressCubit =
        context.read<UpdateAddressCubit>();

    return CustomScaffoldWidget(
      body: BlocListener<UpdateAddressCubit, UpdateAddressStateModel>(
        listener: (context, state) {},
        child: Column(
          children: <Widget>[
            verticalSpace(),
            const AppBarWidget('Add Address'),
            verticalSpace(30),
            SizedBox(
              height: sp(180),
              width: double.infinity,
              child: const CustomImageWidget(
                imageTypes: ImageTypes.asset,
                imageUrl: 'assets/images/map.png',
              ),
            ),
            verticalSpace(30),
            const UpdateAddressFormWidget(),
          ],
        ),
      ),
    );
  }
}
