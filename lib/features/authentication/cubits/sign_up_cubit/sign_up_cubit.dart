import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/crashlytics_helper.dart';
import '../../../../cores/utils/firebase_auth_exception.dart';
import '../../../../cores/utils/local_storage.dart';
import '../../enum/auth_enum.dart';
import '../../models/sign_up_model.dart';
import '../../repository/sign_up_repositry.dart';

class SignUpCubit extends Cubit<SignUpModel> {
  SignUpCubit({
    required this.signUpRepository,
  }) : super(const SignUpModel());

  final SignUpRepository signUpRepository;
  final LocalStorage _localStorage = LocalStorage.instance;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onEmailChange(String email) {
    emit(state.copyWith(email: email, signUpStatus: SignUpStatus.unknown));
  }

  void onMobileChange(String mobile) {
    emit(state.copyWith(mobile: mobile, signUpStatus: SignUpStatus.unknown));
  }

  void onPasswordChange(String password) {
    emit(
      state.copyWith(password: password, signUpStatus: SignUpStatus.unknown),
    );
  }

  void onNameChange(String name) {
    emit(state.copyWith(name: name, signUpStatus: SignUpStatus.unknown));
  }

  Future<void> onSubmittedForm() async {
    try {
      emit(state.copyWith(signUpStatus: SignUpStatus.busy, exceptionText: ''));

      state.validateModel();

      String? uid =
          await signUpRepository.signUpUserWithEmailAndPassword(state);

      emit(state.copyWith(id: uid));

      await signUpRepository.saveUserDataToDataBase(state);

      await _localStorage.saveLoginDetails(state.email, state.password);

      emit(state.copyWith(signUpStatus: SignUpStatus.success));
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
