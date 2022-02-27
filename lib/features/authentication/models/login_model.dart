import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';

class LoginModel extends Equatable{
  const LoginModel({
    required this.email,
    required this.password,
    this.exceptionText = '',
    this.loginStatus = LoginStatus.unknown,
  });

  final String email;
  final String password;
  final String exceptionText;
  final LoginStatus loginStatus;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'exceptionText': exceptionText,
    };
  }

  

  LoginModel copyWith({
    String? email,
    String? password,
    String? exceptionText,
    LoginStatus? loginStatus,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      exceptionText: exceptionText ?? this.exceptionText,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  
  List<Object?> get props => [email, password, exceptionText, loginStatus];
}
