import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/login_services/adminlogin_services.dart';

class AdminLoginProvider extends ChangeNotifier {
  final AdminLoginServices loginServices = AdminLoginServices();
  String errorMessage = '';
  bool isLoggedIn = false;
  bool isLoading = false;
  String? token;

  Future<bool> login(String email, String password) async {
    isLoading = true;

    try {
      final success = await loginServices.adminLogin(email, password);
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
      log('Error during login: $e');
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
      log('Admin logged out successfully.');
    } catch (e) {
      errorMessage = ('Error during logout: ${loginServices.errorMessage}');
    } finally {
      notifyListeners();
    }
  }
}
