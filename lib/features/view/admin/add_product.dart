import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/admin_side/admin_login.dart';
import 'package:pets_shop/features/controllers/admin_side/admin_product_providers.dart';
import 'package:provider/provider.dart';
import '../../../data/models/products/products.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController srcController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController actualPriceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController sideImgController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: srcController,
                decoration:
                    const InputDecoration(labelText: 'Image Source URL'),
              ),
              TextFormField(
                controller: linkController,
                decoration: const InputDecoration(labelText: 'Product Link'),
              ),
              TextFormField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: actualPriceController,
                decoration: const InputDecoration(labelText: 'Actual Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: sizeController,
                decoration: const InputDecoration(labelText: 'Size'),
              ),
              TextFormField(
                controller: sideImgController,
                decoration:
                    const InputDecoration(labelText: 'Side Image Index'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: keyController,
                decoration: const InputDecoration(labelText: 'Key'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Use `listen: false` to access the provider outside the widget tree
                    final authToken = Provider.of<AdminLoginProvider>(
                      context,
                      listen: false,
                    ).token;

                    if (authToken != null) {
                      // Create a new product object
                      Data product = Data(
                        title: titleController.text,
                        category: categoryController.text,
                        src: srcController.text,
                        link: linkController.text,
                        productName: productNameController.text,
                        actualPrice: double.parse(actualPriceController.text),
                        size: sizeController.text,
                        sideImg: int.parse(sideImgController.text),
                        key: keyController.text,
                      );

                      // Use `listen: false` for `AdminProductProvider`
                      Provider.of<AdminProductProvider>(
                        context,
                        listen: false,
                      ).addProduct(product, authToken);

                      // Clear the form
                      titleController.clear();
                      categoryController.clear();
                      srcController.clear();
                      linkController.clear();
                      productNameController.clear();
                      actualPriceController.clear();
                      sizeController.clear();
                      sideImgController.clear();
                      keyController.clear();

                      // Navigate back
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Authentication token is missing!'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
