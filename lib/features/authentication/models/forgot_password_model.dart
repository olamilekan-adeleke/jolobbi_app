import 'package:equatable/equatable.dart';

import '../enum/auth_enum.dart';

class ForgotPasswordModel extends Equatable {
  const ForgotPasswordModel({
    this.exceptionText = '',
    this.email = '',
    this.forgotPasswordStatus = ForgotPasswordStatus.unknown,
  });

  final String exceptionText;
  final String email;
  final ForgotPasswordStatus forgotPasswordStatus;

  @override
  List<Object?> get props => [];

  ForgotPasswordModel copyWith({
    String? exceptionText,
    String? email,
    ForgotPasswordStatus? forgotPasswordStatus,
  }) {
    return ForgotPasswordModel(
      exceptionText: exceptionText ?? this.exceptionText,
      email: email ?? this.email,
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
    );
  }
}
