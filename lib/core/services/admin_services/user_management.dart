import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/models/admin/admin_user/admin_user.dart';

class UserManagement {
  String errorMessage = '';
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  Future<List<Data>> getAllUsers() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) {
      log("Auth token is null. User might not be logged in.");
      return [];
    }

    const baseUrl = 'https://node-project-amber.vercel.app/admin/users';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response =
          await dio.get(baseUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => Data.fromJson(json)).toList();
      } else {
        errorMessage = ("Unexpected error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage =
            ("Error fetching cart: ${e.response!.statusCode} - ${e.response!.data}");
      } else {
        errorMessage = ("Request failed: ${e.message}");
      }
    }
    return [];
  }
}
