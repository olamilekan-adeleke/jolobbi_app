import 'dart:convert';

class UserProfileDataModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final String? mobile;
  final String? profileUrl;
  final int? dateJoined;

  const UserProfileDataModel({
    this.id = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.mobile = '',
    this.profileUrl,
    this.dateJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'mobile': mobile,
      'profileUrl': profileUrl,
      'dateJoined': dateJoined,
    };
  }

  factory UserProfileDataModel.fromMap(Map<String, dynamic> map) {
    return UserProfileDataModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'],
      profileUrl: map['profileUrl'],
      dateJoined: map['dateJoined']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileDataModel.fromJson(String source) =>
      UserProfileDataModel.fromMap(json.decode(source));
}
