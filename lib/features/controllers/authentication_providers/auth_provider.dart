import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/register_services/register-services.dart';
import 'package:pets_shop/data/models/user/user.dart';

class AuthProvider extends ChangeNotifier {
  final RegistrationServices registrationServices = RegistrationServices();

  User? user;
  String? errorMessage;
  bool isLoading = false;
  Future<void> signUp({
    required String username,
    required String password,
    required String email,
    required String name,
  }) async {
    isLoading = true;
    try {
      final newUser = User(
        username: username,
        password: password,
        email: email,
        name: name,
      );
      await registrationServices.getToken();
      log('New user: ${registrationServices.getToken()}');
      await registrationServices.registerUser(newUser);
      user = newUser;
      errorMessage = null;
      notifyListeners();
    } catch (error) {
      errorMessage = 'Error During Registration }';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
