import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';
import 'package:equatable/equatable.dart';

class SignUpModel extends Equatable {
  final String id;
  final String email;
  final String password;
  final String name;
  final String mobile;
  final String profileUrl;
  final int? dateJoined;
  final SignUpStatus signUpStatus;
  final String exceptionText;

  const SignUpModel({
    this.id = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.mobile = '',
    this.profileUrl = '',
    this.dateJoined,
    this.signUpStatus = SignUpStatus.unknown,
    this.exceptionText = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'mobile': mobile,
      'profileUrl': profileUrl,
      'dateJoined': dateJoined ?? Timestamp.now().millisecondsSinceEpoch,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      id: map['id'],
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      dateJoined: map['dateJoined']?.toInt(),
    );
  }

  
  bool validateModel() {
    if (id.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        mobile.isNotEmpty &&
        profileUrl.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  List<Object?> get props => [
        id,
        email,
        password,
        name,
        mobile,
        profileUrl,
        signUpStatus,
        exceptionText,
      ];
}
