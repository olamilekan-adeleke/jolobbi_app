import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/utils/crashlytics_helper.dart';
import 'package:jolobbi_app/cores/utils/firebase_auth_exception.dart';
import 'package:jolobbi_app/cores/utils/local_storage.dart';
import 'package:jolobbi_app/features/authentication/cubits/auth_state_cubit.dart';
import 'package:jolobbi_app/features/authentication/enum/auth_enum.dart';
import 'package:jolobbi_app/features/authentication/repository/sign_up_repositry.dart';

import '../../models/sign_up_model.dart';

class SignUpCubit extends Cubit<SignUpModel> {
  SignUpCubit({
    required this.authenticationState,
    required this.signUpRepository,
  }) : super(const SignUpModel());

  final AuthenticatedState authenticationState;
  final SignUpRepository signUpRepository;
  final LocalStorage _localStorage = LocalStorage.instance;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onEmailChange(String email) => emit(state.copyWith(email: email));

  void onPasswordChange(String password) =>
      emit(state.copyWith(password: password));

  void onNamedChange(String name) => emit(state.copyWith(name: name));

  void onMobileChange(String mobile) => emit(state.copyWith(mobile: mobile));

  void onProfileUrlUpdate(String profileUrl) =>
      emit(state.copyWith(profileUrl: profileUrl));

  Future<void> onSubmittedForm() async {
    try {
      emit(state.copyWith(signUpStatus: SignUpStatus.busy));

      if (!state.validateModel()) {
        throw 'Model Validation Not Passed!';
      }

      await signUpRepository.signUpUserWithEmailAndPassword(state);

      await signUpRepository.saveUserDataToDataBase(state);

      await _localStorage.saveLoginDetails(state.email, state.password);

      emit(state.copyWith(signUpStatus: SignUpStatus.success));
      authenticationState.copyWith(
        authStatus: AuthenticatedStatus.authenticated,
      );
    } on FirebaseAuthException catch (e, s) {
      final String error = AuthExceptionHandler.catchError(e);

      emit(
        state.copyWith(
          signUpStatus: SignUpStatus.error,
          exceptionText: error,
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'signUp-onSubmittedForm',
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          signUpStatus: SignUpStatus.error,
          exceptionText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'signUp-onSubmittedForm',
      );
    }
  }
}
