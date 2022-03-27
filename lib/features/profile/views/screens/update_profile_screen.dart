import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../cubit/profile_details_cubit.dart';
import '../../cubit/update_profile_cubit.dart';
import '../../enum/profile_enum.dart';
import '../../model/update_user_profile_model.dart';
import '../widgets/update_profile_form_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  static const String route = '/update-profile-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: BlocListener<UpdateProfileCubit, UpdateUserProfileStateModel>(
        listener: (context, state) {
          if (state.status == UpdateProfileStatus.success) {
            context.read<ProfileDetailsCubit>().getCurrentLoginUserData();
            SnackBarService.showSuccessSnackBar(
              context: context,
              message: 'Profile Update Successful!',
            );
          } else if (state.status == UpdateProfileStatus.error) {
            SnackBarService.showErrorSnackBar(
              context: context,
              message: state.errorText,
            );
          }
        },
        child: Column(
          children: <Widget>[
            verticalSpace(),
            const AppBarWidget('My Account'),
            verticalSpace(20),
            const UpdateProfileFormWidget(),
          ],
        ),
      ),
    );
  }
}
