import 'package:jolobbi_app/features/profile/model/user_profile_data_model.dart';

import '../repository/profile_repository.dart';

class ProfileService {
  static final ProfileRepository _profileRepository = ProfileRepository();

  Future<UserProfileDataModel> getLoginUserData() async {
    final Map<String, dynamic> data = await _profileRepository.getUserData();

    return UserProfileDataModel.fromMap(data);
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    await _profileRepository.updateUserData(data);
  }

  Future<String> uploadImage(String filePath) async {
    final String imageUrl = await _profileRepository.uploadImage(filePath);

    return imageUrl;
  }
}
