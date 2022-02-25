import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/authentication/models/login_model.dart';


class LoginCubit extends Cubit<LoginModel> {
  LoginCubit() : super(LoginModel(username: '', password: ''));

  
}