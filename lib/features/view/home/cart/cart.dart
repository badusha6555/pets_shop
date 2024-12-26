import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/home_providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void initState() {
    Future.microtask(() async {
      await Provider.of<CartProvider>(context, listen: false).fetchCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 222),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 240, 222),
        title: Text("Cart"),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : cartProvider.errorMessage.isNotEmpty
                  ? Center(child: Text(cartProvider.errorMessage))
                  : cartProvider.cartList.isEmpty
                      ? Center(child: Text("Cart is empty"))
                      : ListView.builder(
                          itemCount: cartProvider.cartList.length,
                          itemBuilder: (context, index) {
                            final item = cartProvider.cartList[index];
                            return ListTile(
                              leading:
                                  CircleAvatar(child: Image.network(item.src!)),
                              title: Text(item.productName!),
                              subtitle: Text("\$${item.id}"),
                            );
                          },
                        );
        },
      ),
    );
  }
}
