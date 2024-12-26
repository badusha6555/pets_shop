import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String productCategory;
  final String description;
  const ProductDetailsPage({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.productCategory,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 222),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 240, 222),
        automaticallyImplyLeading: false,
        title: Text("Product Details "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageUrl,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: $productCategory',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
