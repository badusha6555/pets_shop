import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/wishlist_services/wishlist_services.dart';
import 'dart:developer';
import 'package:pets_shop/data/models/wishlist/wishlist.dart';

class WishListProvider extends ChangeNotifier {
  String errorMessage = '';
  List<Data> wishListData = [];
  WishListServices wishListServices = WishListServices();
  bool isLoading = false;
  Future adddToWhislist(String? id) async {
    isLoading = true;
    notifyListeners();
    try {
      await wishListServices.addtoWhisList(id);
      errorMessage = wishListServices.errorMessage;
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFromWishList(String? id, index) async {
    try {
      await wishListServices.deleteFromWishList(id);
      wishListData.removeAt(index);
      notifyListeners();
    } catch (e) {
      errorMessage = "error in delete";
      log("$e");
    }
  }

  Future<void> getAllWishListData() async {
    isLoading = true;
    notifyListeners();
    try {
      wishListData = await wishListServices.getallData();
      log(wishListData.toString());
      log("succes to get inlist");
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isInWishlist(String id) {
    return wishListData.any((item) => item.id == id);
  }
}
