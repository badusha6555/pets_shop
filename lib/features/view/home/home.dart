import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/authentication_providers/login_provider.dart';
import 'package:pets_shop/features/view/home/cart/cart.dart';
import 'package:pets_shop/features/view/home/widgets/cat_list.dart';
import 'package:pets_shop/features/view/home/widgets/product_list.dart';
import 'package:pets_shop/features/view/home/wishlist/wishlist_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 240, 222),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 253, 240, 222),
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite_rounded,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const WishListPage();
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const CartPage();
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<LoginProvider>(
              builder: (context, loginProvider, _) => IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  loginProvider.logout().then((_) {
                    Navigator.pushReplacementNamed(context, '/login');
                  });
                },
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dog'),
              Tab(text: 'Cat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [DogProductList(), CatList()],
        ),
      ),
    );
  }
}
