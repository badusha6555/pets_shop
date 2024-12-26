import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pets_shop/data/models/cart/cart.dart';

class CartServices {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  String errorMessage = '';
  Future<void> addToCart(String? productId) async {
    if (productId == null || productId.isEmpty) {
      errorMessage = ("Invalid Product ID");
      return;
    }
    final token = await storage.read(key: 'auth_token');
    if (token == null) {
      errorMessage = ("Auth token is null. User might not be logged in.");
      return;
    }
    final baseUrl = 'https://node-project-amber.vercel.app/$productId/cart';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    log("product id : $productId");
    try {
      final response =
          await dio.post(baseUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessage =
            ("Item added to cart successfully: ${response.data['message']}");
      } else {
        errorMessage =
            ("Unexpected status code: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage =
            ("Error adding to cart: ${e.response!.statusCode} - ${e.response!.data}");

        if (e.response!.statusCode == 500) {
          errorMessage = ("Server error occurred. Please try again later.");
        }
      } else {
        errorMessage = ("Request failed: ${e.message}");
      }
    }
  }

  Future<List<Data>> getCart() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) {
      errorMessage = ("Auth token is null. User might not be logged in.");
      return [];
    }

    const baseUrl = 'https://node-project-amber.vercel.app/:id/cart';
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
        errorMessage = ("Unexpected status code: ${response.statusCode}");
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
