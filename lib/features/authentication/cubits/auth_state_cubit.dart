import 'package:equatable/equatable.dart';

import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';

class AuthenticatedState extends Equatable {
  const AuthenticatedState({
    this.authStatus = AuthenticatedStatus.unauthenticated,
  });

  final AuthenticatedStatus authStatus;

  AuthenticatedState copyWith({
    AuthenticatedStatus? authStatus,
  }) {
    return AuthenticatedState(
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [authStatus];
}
