import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/app_bar_widget.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/profile_details_cubit.dart';
import '../../model/user_profile_state_model.dart';
import '../widgets/update_profile_form_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  static const String route = '/update-profile-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: BlocListener<ProfileDetailsCubit, UserProfileStateModel>(
        listener: (context, state) {},
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
