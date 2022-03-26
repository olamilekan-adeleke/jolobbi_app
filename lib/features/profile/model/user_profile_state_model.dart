import '../enum/profile_enum.dart';
import 'user_profile_data_model.dart';

class UserProfileStateModel {
  final UserProfileDataModel? userData;
  final String exceptionText;
  final ProfileDetailsStatus status;

  UserProfileStateModel({
    this.userData,
    this.exceptionText = '',
    this.status = ProfileDetailsStatus.unknown,
  });

  UserProfileStateModel copyWith({
    UserProfileDataModel? userData,
    String? exceptionText,
    ProfileDetailsStatus? status,
  }) {
    return UserProfileStateModel(
      userData: userData ?? this.userData,
      exceptionText: exceptionText ?? this.exceptionText,
      status: status ?? this.status,
    );
  }
}
