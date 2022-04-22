import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/authentication/models/login_model.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();
  LocalStorage._internal();
  factory LocalStorage() => instance;
  String userEmail = '';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final loginDetailsKey = 'LoginDetailsKey';
  final cartKey = 'cartKey';

  Future<void> saveLoginDetails(String email, String password) async {
    try {
      final Map data = {'email': email, 'password': password};
      final String value = json.encode(data);

      await storage.write(key: loginDetailsKey, value: value);
      userEmail = email;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LoginModel> getSavedUser() async {
    LoginModel _loginModel;

    try {
      final String? value = await storage.read(key: loginDetailsKey);

      if (value == null) {
        throw 'No User Was Found, Please Login With Email And Password';
      }

      final Map<String, dynamic> data = json.decode(value);

      _loginModel = LoginModel(
        email: data['email'],
        password: data['password'],
      );

      userEmail = data['email'];
    } catch (e) {
      throw e.toString();
    }

    return _loginModel;
  }

  Future<void> saveCartItem(List<Map<String, dynamic>> items) async {
    try {
      final String value = json.encode(items);

      await storage.write(key: cartKey, value: value);
    } catch (_) {}
  }

  Future<List<Map<String, dynamic>>?> getCartItem() async {
    try {
      final String? value = await storage.read(key: cartKey);

      if (value == null) return null;

      final List<dynamic> data = json.decode(value);

      return List<Map<String, dynamic>>.from(data);
    } catch (_) {
      return null;
    }
  }
}
