import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/admin_services/admin_product_services.dart';
import 'package:pets_shop/data/models/products/products.dart';

class AdminProductProvider with ChangeNotifier {
  final AdminProductService productService = AdminProductService();

  Future<bool> addProduct(Data product, String authToken) async {
    try {
      final success = await productService.postProduct(product, authToken);
      if (success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
