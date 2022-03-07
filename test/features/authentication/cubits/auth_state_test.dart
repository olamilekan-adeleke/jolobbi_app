import 'package:flutter_test/flutter_test.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';

void main() {
  group(
    'Authentication State',
    () {
      late AuthenticatedStateCubit sut;

      setUp(() {
        sut = const AuthenticatedStateCubit();
      });

      test(
        'Check initial value is [AuthenticatedStatus.unauthenticated]',
        () {
          expect(sut.authStatus, AuthenticatedStatus.unauthenticated);
        },
      );
    },
  );
}
