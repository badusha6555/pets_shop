import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/cart_services/cart_services.dart';
import 'package:pets_shop/data/models/cart/cart.dart';

class CartProvider extends ChangeNotifier {
  String errorMessage = '';
  final CartServices cartServices = CartServices();
  List<Data> cartList = [];
  bool isLoading = false;
  void addCart({required String productId}) async {
    try {
      isLoading = true;
      notifyListeners();
      await cartServices.addToCart(productId);
      log("Product added to cart successfully.");
    } catch (e) {
      errorMessage =
          "Error adding product to cart: ${cartServices.errorMessage}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCart() async {
    try {
      isLoading = true;
      notifyListeners();
      cartList = await cartServices.getCart();
    } catch (e) {
      errorMessage = "Error fetching cart: ${cartServices.errorMessage}";
      log('Error fetching cart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
