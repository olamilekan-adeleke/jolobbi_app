import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/utils/crashlytics_helper.dart';
import 'package:jolobbi_app/cores/utils/firebase_auth_exception.dart';
import 'package:jolobbi_app/cores/utils/local_storage.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';
import 'package:jolobbi_app/features/authentication/models/login_model.dart';
import 'package:jolobbi_app/features/authentication/repository/login_repository.dart';

class LoginCubit extends Cubit<LoginModel> {
  LoginCubit({
    required this.loginRepository,
  }) : super(const LoginModel(email: '', password: ''));

  final LoginRepository loginRepository;
  final LocalStorage _localStorage = LocalStorage.instance;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onEmailChange(String email) {
    emit(state.copyWith(email: email, loginStatus: LoginStatus.unknown));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: password, loginStatus: LoginStatus.unknown));
  }

  Future<void> onSubmitFom() async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.busy, exceptionText: ''));

      state.validateModel();

      await loginRepository.loginUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      await _localStorage.saveLoginDetails(state.email, state.password);

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } on FirebaseAuthException catch (e, s) {
      final String error = AuthExceptionHandler.catchError(e);

      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          exceptionText: error,
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'login-onSubmitFom',
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          exceptionText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'login-onSubmitFom',
      );
    }
  }

  Future<void> biometricLogin() async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.busy, exceptionText: ''));

      bool didAuthenticate = await loginRepository.useBiometricLogin();

      if (didAuthenticate == false) {
        throw 'Could Not Authenticate User Using Biometric';
      }

      LoginModel _loginModel = await _localStorage.getSavedUser();

      emit(
        state.copyWith(
          email: _loginModel.email,
          password: _loginModel.password,
        ),
      );

      state.validateModel();

      await loginRepository.loginUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } on FirebaseAuthException catch (e, s) {
      final String error = AuthExceptionHandler.catchError(e);

      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          exceptionText: error,
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'login-biometricLogin',
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          exceptionText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'login-biometricLogin',
      );
    }
  }
}
