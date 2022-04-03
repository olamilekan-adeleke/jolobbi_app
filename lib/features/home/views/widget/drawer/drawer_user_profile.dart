import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../profile/cubit/user_profile/profile_details_cubit.dart';
import '../../../../profile/enum/profile_enum.dart';
import '../../../../profile/model/user_profile_state_model.dart';

class DrawerUserProfileWidget extends StatelessWidget {
  const DrawerUserProfileWidget({
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

        return Row(
          children: [
            SizedBox(
              height: sp(45),
              width: sp(45),
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
            horizontalSpace(10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '${state.userData?.name}',
                    fontSize: sp(14),
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textColor: kcWhite,
                  ),
                  TextWidget(
                    '${state.userData?.email}',
                    fontSize: sp(12),
                    fontWeight: FontWeight.w300,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textColor: kcWhite,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
