import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pets_shop/data/models/wishlist/wishlist.dart';

class WishListServices {
  String errorMessage = '';
  FlutterSecureStorage storage = FlutterSecureStorage();
  Dio dio = Dio();

  Future<void> addtoWhisList(String? id) async {
    final token = await storage.read(key: 'auth_token');
    final baseUrl = 'https://node-project-amber.vercel.app/$id/wishlists';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          await dio.post(baseUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        log('Item added to whislist');
      } else {
        errorMessage = ('not added and failed');
      }
    } catch (e) {
      if (e is DioException) {
        errorMessage = ('${e.response?.statusMessage}-${e.response?.data}');
      }
    }
  }

  Future<List<Data>> getallData() async {
    final token = await storage.read(key: 'auth_token');
    const baseUrl = 'https://node-project-amber.vercel.app/:id/wishlists';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          await dio.get(baseUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        log("sucess to get the data ");
        List<dynamic> data = response.data['data'];
        return data.map((i) => Data.fromJson(i)).toList();
      } else {
        throw Exception('error to fecth items');
      }
    } catch (e) {
      if (e is DioException) {
        log('${e.response?.statusMessage}');
      } else {
        log(e.toString());
      }
    }
    return [];
  }

  Future<void> deleteFromWishList(String? id) async {
    final token = await storage.read(key: 'auth_token');
    final baseUrl = 'https://node-project-amber.vercel.app/$id/wishlists';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          await dio.delete(baseUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        log('Item added to whislist');
      } else {
        errorMessage = ('Can not delete the item');
      }
    } catch (e) {
      if (e is DioException) {
        log('${e.response?.statusMessage}-${e.response?.data}');
      }
    }
  }
}
