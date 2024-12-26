import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pets_shop/core/services/admin_services/user_management.dart';
import '../../../data/models/admin/admin_user/admin_user.dart';

class UserManagementProvider extends ChangeNotifier {
  final UserManagement userManagement = UserManagement();

  bool isLoading = false;
  List<Data> users = [];
  String errorMessage = '';
  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();
    try {
      List<Data> fetchedUsers = await userManagement.getAllUsers();
      if (fetchedUsers.isNotEmpty) {
        users = fetchedUsers;
      } else {
        errorMessage = 'No users found';
      }
    } catch (e) {
      errorMessage = 'Failed to load users: ${userManagement.errorMessage}';
      log('Error fetching users: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
