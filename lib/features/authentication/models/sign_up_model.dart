import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../enum/auth_enum.dart';

class SignUpModel extends Equatable {
  final String id;
  final String email;
  final String password;
  final String name;
  final String? mobile;
  final String? profileUrl;
  final int? dateJoined;
  final SignUpStatus signUpStatus;
  final String exceptionText;

  const SignUpModel({
    this.id = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.mobile = '',
    this.profileUrl,
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
      mobile: map['mobile'],
      profileUrl: map['profileUrl'],
      dateJoined: map['dateJoined'],
    );
  }

  bool validateModel() {
    if (email.isEmpty) throw 'Email Is Required!';
    if (password.isEmpty) throw 'Password Is Required!';
    if (name.isEmpty) throw 'Name Is Required!';

    return true;
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

  SignUpModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? mobile,
    String? profileUrl,
    int? dateJoined,
    SignUpStatus? signUpStatus,
    String? exceptionText,
  }) {
    return SignUpModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      profileUrl: profileUrl ?? this.profileUrl,
      dateJoined: dateJoined ?? this.dateJoined,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      exceptionText: exceptionText ?? this.exceptionText,
    );
  }
}
