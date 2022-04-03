import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/error_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/components/loading_indicator.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/user_profile/profile_details_cubit.dart';
import '../../enum/profile_enum.dart';
import '../../model/user_profile_state_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          children: [
            SizedBox(
              height: sp(80),
              width: sp(80),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sp(100)),
                child: Container(
                  color: kcWhite,
                  child: CustomImageWidget(
                    imageUrl: state.userData?.profileUrl ?? '',
                    imageTypes: ImageTypes.profile,
                  ),
                ),
              ),
            ),
            verticalSpace(),
            TextWidget(
              '${state.userData?.name}',
              fontSize: sp(16),
              fontWeight: FontWeight.w500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            TextWidget(
              '${state.userData?.email}',
              fontSize: sp(15),
              fontWeight: FontWeight.w300,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textColor: kcIconGrey,
            ),
            TextWidget(
              '${state.userData?.mobile}',
              fontSize: sp(15),
              fontWeight: FontWeight.w300,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textColor: kcIconGrey,
            ),
          ],
        );
      },
    );
  }
}
