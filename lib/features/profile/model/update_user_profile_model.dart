import 'dart:convert';

import '../enum/profile_enum.dart';

class UpdateUserProfileStateModel {
  final String email;
  final String name;
  final String mobile;
  final String profileUrl;
  final String filePath;
  final String errorText;
  final UpdateProfileStatus status;

  const UpdateUserProfileStateModel({
    this.email = '',
    this.name = '',
    this.mobile = '',
    this.filePath = '',
    this.profileUrl = '',
    this.errorText = '',
    this.status = UpdateProfileStatus.unknown,
  });

  UpdateUserProfileStateModel copyWith({
    String? email,
    String? name,
    String? mobile,
    String? profileUrl,
    String? filePath,
    String? errorText,
    UpdateProfileStatus? status,
  }) {
    return UpdateUserProfileStateModel(
      email: email ?? this.email,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      filePath: filePath ?? this.filePath,
      profileUrl: profileUrl ?? this.profileUrl,
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (name.isNotEmpty) 'name': name,
      if (mobile.isNotEmpty) 'mobile': mobile,
      if (profileUrl.isNotEmpty) 'profileUrl': profileUrl,
    };
  }
}
