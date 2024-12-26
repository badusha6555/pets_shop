// ignore_for_file: file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pets_shop/data/models/user/user.dart';

class RegistrationServices {
  String errorMessage = '';
  final Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  RegistrationServices()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        );

  Future<void> registerUser(User userData) async {
    try {
      log('Registering user: ${userData.toJson()}');

      final response = await dio.post(
        "https://node-project-amber.vercel.app/register",
        data: userData.toJson(),
      );

      log('Response from register: ${response.statusCode} ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        await storage.write(key: 'auth_token', value: token);

        if (data['status'] == 'success') {
          log('User registered successfully. Token: $token');
        } else {
          errorMessage =
              ('Registration failed: ${data['message'] ?? "Unknown error"}');
        }
      } else {
        log('Unexpected response status: ${response.statusCode}');
        log('Response data: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        log('DioException: ${e.message}');
        log('Request data: ${e.requestOptions.data}');
        log('Response data: ${e.response?.data}');
        log('Response status code: ${e.response?.statusCode}');
      } else {
        log('Unexpected error: $e');
      }
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await storage.read(key: 'auth_token');
      log('Retrieved token: $token');
      if (token == null || token.isEmpty) {
        log('No token found or token is empty.');
        return null;
      }
      return token;
    } catch (e) {
      log('Error reading token: $e');
      return null;
    }
  }
}
