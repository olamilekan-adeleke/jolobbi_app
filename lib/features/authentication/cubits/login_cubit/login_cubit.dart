import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';
import 'package:jolobbi_app/features/authentication/models/login_model.dart';
import 'package:jolobbi_app/features/authentication/repository/login_repository.dart';

class LoginCubit extends Cubit<LoginModel> {
  LoginCubit({
    required this.authenticationState,
    required this.loginRepository,
  }) : super(const LoginModel(email: '', password: ''));

  final AuthenticatedState authenticationState;
  final LoginRepository loginRepository;

  void onEmailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> onSubmitFom() async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.busy));

      await loginRepository.loginUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } catch (e) {
      final String error = '';

      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          exceptionText: error,
        ),
      );
    }
  }

  void biometricLogin() {}
}
