import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginServices {
  String errorMessage = '';
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<bool> loginUser(String username, String password) async {
    try {
      final response = await dio.post(
        'https://node-project-amber.vercel.app/login',
        data: {
          "username": username,
          "password": password,
        },
      );
      log('Response from login: ${response.statusCode} ${response.data}');
      if (response.statusCode == 200) {
        final token = response.data['token'];
        if (token != null) {
          await storage.write(key: 'auth_token', value: token);
          log('Token saved successfully: $token');
          return true;
        } else {
          log('Login successful, but no token received from the server.');
          return false;
        }
      } else if (response.statusCode == 401) {
        errorMessage =
            'Login failed: Unauthorized (401). Please check credentials.';
        return false;
      } else {
        log('Login failed. Status code: ${response.statusCode}');
        log('Response: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      log('Login error: ${e.response?.statusCode} ${e.response?.data ?? e.message}');
      if (e.response?.statusCode == 401) {
        log('Unauthorized error: Invalid username or password.');
      }
    } catch (e) {
      log('Unexpected error during login: $e');
    }
    return false;
  }

  Future<String?> getToken() async {
    try {
      final token = await storage.read(key: 'auth_token');
      log('Retrieved token: $token');
      if (token == null || token.isEmpty) {
        errorMessage = 'No token found or token is empty.';
        return null;
      }
      return token;
    } catch (e) {
      errorMessage = 'Error reading token: $e';
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await storage.delete(key: 'auth_token');
      errorMessage = "Logged out successfully.";
    } catch (e) {
      errorMessage = 'Error during logout: $e';
    }
  }

  // Future<bool> isLoggedIn() async {
  //   try {
  //     final token = await getToken();
  //     final isLoggedIn = token != null;
  //     log('Is user logged in? $isLoggedIn');
  //     return isLoggedIn;
  //   } catch (e) {
  //     log('Error checking login status: $e');
  //     return false;
  //   }
  // }
}
