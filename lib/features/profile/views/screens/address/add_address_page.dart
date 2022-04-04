import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/snack_bar_service.dart';
import '../../../cubit/address_cubit/update_address_cubit.dart';
import '../../../cubit/user_profile/profile_details_cubit.dart';
import '../../../enum/profile_enum.dart';
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
        listener: (context, state) {
          if (state.status == UpdateAddressStatus.error) {
            SnackBarService.showErrorSnackBar(
              context: context,
              message: state.errorText,
            );
          } else if (state.status == UpdateAddressStatus.success) {
            SnackBarService.showSuccessSnackBar(
              context: context,
              message: 'Address Successfully added!',
            );

            context.read<ProfileDetailsCubit>().getCurrentLoginUserData();

            AppRouter.instance.goBack();
          }
        },
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
            verticalSpace(40),
            BlocBuilder<UpdateAddressCubit, UpdateAddressStateModel>(
              builder: (context, state) {
                if (state.status == UpdateAddressStatus.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Add Address',
                  onTap: updateAddressCubit.addAddress,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
