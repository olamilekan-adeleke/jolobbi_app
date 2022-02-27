import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/sign_up_model.dart';

class SignUpCubit extends Cubit<SignUpModel> {
  SignUpCubit() : super(const SignUpModel());
}