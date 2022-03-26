import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/profile_enum.dart';
import '../model/update_user_profile_model.dart';
import '../service/profile_service.dart';

class UpdateProfileCubit extends Cubit<UpdateUserProfileStateModel> {
  UpdateProfileCubit(this.profileService)
      : super(const UpdateUserProfileStateModel());

  final ProfileService profileService;

  void onMobileChange(String mobile) {
    emit(state.copyWith(mobile: mobile, status: UpdateProfileStatus.unknown));
  }

  void onNameChange(String name) {
    emit(state.copyWith(name: name, status: UpdateProfileStatus.unknown));
  }
}
