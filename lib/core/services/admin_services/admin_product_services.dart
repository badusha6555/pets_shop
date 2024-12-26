import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pets_shop/data/models/products/products.dart';

class AdminProductService {
  String errorMessage = '';
  final Dio dio = Dio();
  final String apiUrl = 'https://node-project-amber.vercel.app/admin/products';

  Future<bool> postProduct(Data product, String authToken) async {
    try {
      log('Product Data: ${product.toJson()}');
      final response = await dio.post(
        apiUrl,
        data: product.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      log('Response status code: ${response.statusCode}');
      log('Response data: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        errorMessage = ('Failed to post product: ${response.data}');
        return false;
      }
    } catch (e) {
      log('Error posting product: $e');
      return false;
    }
  }
}
