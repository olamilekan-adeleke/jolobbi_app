import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../enum/profile_enum.dart';
import '../model/update_user_profile_model.dart';
import '../service/profile_service.dart';

class UpdateProfileCubit extends Cubit<UpdateUserProfileStateModel> {
  UpdateProfileCubit(this.profileService)
      : super(const UpdateUserProfileStateModel());

  final ProfileService profileService;
  final ImagePicker _picker = ImagePicker();
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onMobileChange(String mobile) {
    emit(state.copyWith(mobile: mobile, status: UpdateProfileStatus.unknown));
  }

  void onNameChange(String name) {
    emit(state.copyWith(name: name, status: UpdateProfileStatus.unknown));
  }

  Future<String?> _uploadImage() async {
    if (state.filePath.isEmpty) return null;

    return await profileService.uploadImage(state.filePath);
  }

  Future<void> onPickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    emit(state.copyWith(filePath: image.path));
  }

  Future<void> onSubmittedForm() async {
    try {
      emit(state.copyWith(status: UpdateProfileStatus.busy, errorText: ''));

      String? imageUrl = await _uploadImage();

      await profileService.updateUserData(state.toMap());

      emit(state.copyWith(status: UpdateProfileStatus.success));
    } catch (e, s) {
      emit(
        state.copyWith(
          status: UpdateProfileStatus.error,
          errorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'update-onSubmittedForm',
      );
    }
  }
}
