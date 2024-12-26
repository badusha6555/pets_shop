import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:pets_shop/core/services/api/api_services.dart';
import 'package:pets_shop/data/models/products/products.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductsProvider extends ChangeNotifier {
  String errorMessage = '';
  final ApiServices apiServices = ApiServices();
  Product? product;
  bool isLoading = false;
  Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchProduct() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiServices.getProduct('/products');
      if (response != null) {
        product = response;
        log("Fetched Product: ${product!.data}");
      } else {
        errorMessage = ("No product data.");
      }
    } catch (e) {
      errorMessage = ("Error fetching product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsOfCat() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiServices.getProductsByCategory('/cat');
      if (response != null) {
        product = response;
        log("Fetched Product: ${product!.data}");
      } else {
        log("No product data");
      }
    } catch (e) {
      errorMessage = ("Error fetching product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsOfDog() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiServices.getProductsByCategory('/dog');
      if (response != null) {
        product = response;
        log("Fetched Product In Provider: ${product!.data}");
      } else {
        errorMessage = ("No product data");
      }
    } catch (e) {
      log("Error fetching product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
