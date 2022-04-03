import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/crashlytics_helper.dart';
import '../../enum/profile_enum.dart';
import '../../model/user_profile_data_model.dart';
import '../../model/user_profile_state_model.dart';
import '../../service/profile_service.dart';

class ProfileDetailsCubit extends Cubit<UserProfileStateModel> {
  ProfileDetailsCubit(this.profileService) : super(UserProfileStateModel());

  final ProfileService profileService;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();
  

  Future<void> getCurrentLoginUserData() async {
    try {
      emit(
        state.copyWith(status: ProfileDetailsStatus.busy, exceptionText: ''),
      );

      final UserProfileDataModel userData =
          await profileService.getLoginUserData();

      emit(
        state.copyWith(
          userData: userData,
          status: ProfileDetailsStatus.success,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          status: ProfileDetailsStatus.error,
          exceptionText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getCurrentLoginUserData',
      );
    }
  }



}
