import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/login_services/login_services.dart';

class LoginProvider extends ChangeNotifier {
  final LoginServices loginServices = LoginServices();
  String errorMessage = '';
  bool isLoggedIn = false;
  bool isLoading = false;
  String? token;

  Future<bool> login(String email, String password) async {
    isLoading = true;

    try {
      final success = await loginServices.loginUser(email, password);
      if (success) {
        token = await loginServices.getToken();
        isLoggedIn = true;
        log('Login successful. Token: $token');
        return true;
      } else {
        isLoggedIn = false;
        errorMessage = loginServices.errorMessage;
      }
    } catch (e) {
      errorMessage = ('Error during login: $e');
      isLoggedIn = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await loginServices.logout();
      isLoggedIn = false;
      token = null;
      log('User logged out successfully.');
    } catch (e) {
      log('Error during logout: $e');
    } finally {
      notifyListeners();
    }
  }
}
