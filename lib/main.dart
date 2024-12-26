import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/admin_side/admin_login.dart';
import 'package:pets_shop/features/controllers/admin_side/admin_product_providers.dart';
import 'package:pets_shop/features/controllers/admin_side/user_provider.dart';
import 'package:pets_shop/features/controllers/authentication_providers/auth_provider.dart';
import 'package:pets_shop/features/controllers/home_providers/cart_provider.dart';
import 'package:pets_shop/features/controllers/authentication_providers/login_provider.dart';
import 'package:pets_shop/features/controllers/home_providers/product_provider.dart';
import 'package:pets_shop/features/controllers/home_providers/wishlist_provider.dart';
import 'package:pets_shop/features/view/home/home.dart';
import 'package:pets_shop/features/view/home/startscreen.dart';
import 'package:pets_shop/features/view/home/wishlist/wishlist_page.dart';
import 'package:pets_shop/features/view/login/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AdminLoginProvider()),
        ChangeNotifierProvider(create: (context) => UserManagementProvider()),
        ChangeNotifierProvider(create: (context) => AdminProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartScreen(),
        routes: {
          '/start': (context) => const StartScreen(),
          '/login': (context) => Login(),
          '/home': (context) => const HomeScreen(),
          '/wishlist': (context) => const WishListPage(),
        },
      ),
    );
  }
}
