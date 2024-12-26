import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/home_providers/cart_provider.dart';
import 'package:pets_shop/features/controllers/home_providers/wishlist_provider.dart';
import 'package:pets_shop/features/view/home/widgets/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:pets_shop/features/controllers/home_providers/product_provider.dart';

class DogProductList extends StatefulWidget {
  const DogProductList({super.key});

  @override
  State<DogProductList> createState() => _DogProductListState();
}

class _DogProductListState extends State<DogProductList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchProductsOfDog();
      log("Fetching Dog Products...");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = productProvider.product;

        if (product == null || product.data == null || product.data!.isEmpty) {
          return const Center(
            child: Text('No Dog products available.'),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85),
          padding: const EdgeInsets.all(10),
          itemCount: product.data!.length,
          itemBuilder: (context, index) {
            final productData = product.data![index];
            final productName = productData.productName ?? 'No Title';
            final imageUrl = productData.src ?? 'URL_ADDRESS';
            final productCategory = productData.category ?? 'No Category';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProductDetailsPage(
                      description: productData.productDescription?[0] ?? '',
                      productName: productName,
                      imageUrl: imageUrl,
                      productCategory: productCategory,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    transitionDuration: const Duration(milliseconds: 500),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Card(
                color: const Color.fromARGB(255, 246, 164, 158),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: imageUrl,
                      child: CachedNetworkImage(
                        height: 80,
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            productName,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${productData.actualPrice}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Consumer2<WishListProvider, CartProvider>(
                            builder: (context, wishlistProvider, cartProvider,
                                    child) =>
                                Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      wishlistProvider.adddToWhislist(
                                        productData.sId!,
                                      );
                                    },
                                    icon: const Icon(Icons.favorite_border)),
                                IconButton(
                                    onPressed: () {
                                      cartProvider.addCart(
                                        productId: productData.sId!,
                                      );
                                    },
                                    icon: const Icon(Icons.shopping_cart))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
