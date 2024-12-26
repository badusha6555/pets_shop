import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminLoginServices {
  String errorMessage = '';
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<bool> adminLogin(String username, String password) async {
    try {
      final response = await dio.post(
        'https://node-project-amber.vercel.app/adminLogin',
        data: {
          "adminName": username,
          "password": password,
        },
      );
      log('Response from login: ${response.statusCode} ${response.data}');
      if (response.statusCode == 200) {
        final token = response.data['data'];
        if (token != null) {
          await storage.write(key: 'auth_token', value: token);
          log('Token saved successfully.');
          return true;
        } else {
          log('Login successful, but no token received from the server.');
          return false;
        }
      } else if (response.statusCode == 401) {
        errorMessage =
            ('Login failed: Unauthorized (401). Please check credentials.');
        return false;
      } else {
        log('Login failed. Status code: ${response.statusCode}');
        log('Response: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      log('Login error: ${e.response?.statusCode} ${e.response?.data ?? e.message}');
      if (e.response?.statusCode == 401) {
        errorMessage = ('Unauthorized error: Invalid username or password.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = ('Connection timeout');
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
      return token;
    } catch (e) {
      errorMessage = ('Error reading token: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await storage.delete(key: 'auth_token');
      log('Admin logged out and token deleted successfully.');
    } catch (e) {
      log('Error deleting token: $e');
    }
  }

  Future<bool> isTokenExpired() async {
    try {
      final token = await getToken();
      if (token == null) return true;
      log('Token is valid for now.');
      return false;
    } catch (e) {
      log('Error checking token expiry: $e');
      return true;
    }
  }
}
