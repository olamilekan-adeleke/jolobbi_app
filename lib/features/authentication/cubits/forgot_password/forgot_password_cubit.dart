import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/auth_enum.dart';
import '../../models/forgot_password_model.dart';
import '../../repository/forgot_password_repository.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordModel> {
  ForgotPasswordCubit(this.forgotPasswordRepository)
      : super(const ForgotPasswordModel());

  final ForgotPasswordRepository forgotPasswordRepository;

  void onEmailChange(String email) {
    emit(
      state.copyWith(
        email: email,
        forgotPasswordStatus: ForgotPasswordStatus.unknown,
      ),
    );
  }

  void onSubmitFom() {}
}
