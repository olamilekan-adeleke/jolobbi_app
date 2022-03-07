import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';

class AuthenticatedStateCubit extends Cubit<AuthenticatedStatus> {
  AuthenticatedStateCubit({
    required this.authStatus,
  }) : super(AuthenticatedStatus.unauthenticated);

  final AuthenticatedStatus authStatus;

  AuthenticatedStateCubit copyWith({
    AuthenticatedStatus? authStatus,
  }) {
    return AuthenticatedStateCubit(
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
