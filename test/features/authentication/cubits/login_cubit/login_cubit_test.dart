import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/cubits/login_cubit/login_cubit.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';
import 'package:jolobbi_app/features/authentication/models/login_model.dart';
import 'package:jolobbi_app/features/authentication/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  group(
    'Login Cubit',
    () {
      late LoginCubit sut;
      late AuthenticatedStateCubit authenticationState;
      late LoginRepository mockLoginRepository;

      setUp(() {
        authenticationState = const AuthenticatedStateCubit();
        mockLoginRepository = MockLoginRepository();
        sut = LoginCubit(
          authenticationState: authenticationState,
          loginRepository: mockLoginRepository,
        );
      });

      tearDown(() {
        sut.close();
      });

      test(
        'Check Initial Value of cubit',
        () {
          expect(
            sut.state,
            const LoginModel(
              email: '',
              password: '',
              loginStatus: LoginStatus.unknown,
              exceptionText: '',
            ),
          );
        },
      );

      test(
        'test that onEmailChange and onPassword change works',
        () {
          sut.onEmailChange('ola@gmail.com');
          expect(
            sut.state,
            const LoginModel(
              email: 'ola@gmail.com',
              password: '',
              loginStatus: LoginStatus.unknown,
              exceptionText: '',
            ),
          );

          sut.onPasswordChange('test123456');
          expect(
            sut.state,
            const LoginModel(
              email: 'ola@gmail.com',
              password: 'test123456',
              loginStatus: LoginStatus.unknown,
              exceptionText: '',
            ),
          );
        },
      );

      test(
        'Check for on submit form',
        () async {
          when(
            () => mockLoginRepository.loginUserWithEmailAndPassword(
              email: sut.state.email,
              password: sut.state.password,
            ),
          ).thenAnswer((_) async => true);

          sut.onEmailChange('ola@gmail.com');
          sut.onPasswordChange('test123456');

          expect(
            sut.state,
            const LoginModel(
              email: 'ola@gmail.com',
              password: 'test123456',
              loginStatus: LoginStatus.unknown,
              exceptionText: '',
            ),
          );

          await sut.onSubmitFom();

          // expect(
          //   sut.state,
          //   const LoginModel(
          //     email: 'ola@gmail.com',
          //     password: 'test123456',
          //     loginStatus: LoginStatus.busy,
          //     exceptionText: '',
          //   ),
          // );

          // await future;

          // verify(
          //   () => mockLoginRepository.loginUserWithEmailAndPassword(
          //     email: sut.state.email,
          //     password: sut.state.password,
          //   ),
          // ).called(1);

          // expect(
          //   sut.state,
          //   const LoginModel(
          //     email: 'ola@gmail.com',
          //     password: 'test123456',
          //     loginStatus: LoginStatus.success,
          //     exceptionText: '',
          //   ),
          // );

          // expect(sut.authenticationState, AuthenticatedStatus.authenticated);
        },
      );
    },
  );
}
