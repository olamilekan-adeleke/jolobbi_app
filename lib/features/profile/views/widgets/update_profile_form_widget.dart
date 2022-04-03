import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/components/error_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/components/loading_indicator.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/validator.dart';
import '../../cubit/user_profile/profile_details_cubit.dart';
import '../../cubit/user_profile/update_profile_cubit.dart';
import '../../enum/profile_enum.dart';
import '../../model/update_user_profile_model.dart';
import '../../model/user_profile_state_model.dart';

class UpdateProfileFormWidget extends StatelessWidget {
  const UpdateProfileFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UpdateProfileCubit updateProfileCubit =
        context.watch<UpdateProfileCubit>();

    return BlocBuilder<ProfileDetailsCubit, UserProfileStateModel>(
      builder: (context, state) {
        if (state.status == ProfileDetailsStatus.busy) {
          return const Center(child: CustomLoadingIndicatorWidget());
        }

        if (state.status == ProfileDetailsStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.exceptionText,
              callback: () {
                context.read<ProfileDetailsCubit>().getCurrentLoginUserData();
              },
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: updateProfileCubit.onPickImage,
              child: Center(
                child: SizedBox(
                  height: sp(80),
                  width: sp(80),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: sp(80),
                        width: sp(80),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(sp(100)),
                          child: Container(
                            color: kcWhite,
                            child: CustomImageWidget(
                              imageUrl:
                                  updateProfileCubit.state.filePath.isEmpty
                                      ? (state.userData?.profileUrl ?? '')
                                      : updateProfileCubit.state.filePath,
                              imageTypes:
                                  updateProfileCubit.state.filePath.isEmpty
                                      ? ImageTypes.profile
                                      : ImageTypes.file,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: Icon(
                          Icons.add_a_photo,
                          size: sp(20),
                          color: kcIconGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            verticalSpace(40),
            _text('Name'),
            CustomTextField(
              hintText: state.userData?.name ?? 'Name',
              onChanged: updateProfileCubit.onNameChange,
              validator: nameValidator,
              textInputType: TextInputType.text,
            ),
            verticalSpace(),
            _text('Phone number'),
            CustomTextField(
              hintText: state.userData?.mobile ?? 'Mobile Number',
              onChanged: updateProfileCubit.onMobileChange,
              validator: mobileValidator,
              textInputType: TextInputType.number,
            ),
            verticalSpace(60),
            BlocBuilder<UpdateProfileCubit, UpdateUserProfileStateModel>(
              builder: (context, state) {
                if (state.status == UpdateProfileStatus.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Update Profile',
                  onTap: updateProfileCubit.onSubmittedForm,
                );
              },
            ),
            verticalSpace(20),
          ],
        );
      },
    );
  }

  Widget _text(String title) {
    return TextWidget(title, fontSize: sp(13));
  }
}
