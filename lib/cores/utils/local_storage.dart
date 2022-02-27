import '../../features/authentication/models/login_model.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();
  LocalStorage._internal();
  factory LocalStorage() => instance;

  // final storage = FlutterSecureStorage();

  Future<void> saveLoginDetails(String email, String password) async{}

  Future<LoginModel?> getSavedUser() async {
    return const LoginModel(email: '', password: '');
  }
}
