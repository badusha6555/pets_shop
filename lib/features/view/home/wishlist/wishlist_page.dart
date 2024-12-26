import 'package:flutter/material.dart';
import 'package:pets_shop/features/controllers/home_providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  void initState() {
    Future.microtask(() {
      Provider.of<WishListProvider>(context, listen: false)
          .getAllWishListData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 222),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 240, 222),
        title: const Text('Wishlist'),
      ),
      body: Consumer<WishListProvider>(
        builder: (context, wishListPro, child) {
          if (wishListPro.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (wishListPro.errorMessage.isNotEmpty) {
            return Center(
              child: Text(wishListPro.errorMessage),
            );
          } else if (wishListPro.wishListData.isEmpty) {
            return const Center(
              child: Text('Your WishList is empty'),
            );
          }

          return ListView.builder(
            itemCount: wishListPro.wishListData.length,
            itemBuilder: (context, index) {
              if (wishListPro.wishListData.isEmpty) {
                return const Center(
                  child: Text('Your WishList is empty!'),
                );
              } else {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        wishListPro.wishListData[index].src.toString()),
                  ),
                  title: Text(
                      wishListPro.wishListData[index].productName.toString()),
                  subtitle: Text(
                      wishListPro.wishListData[index].actualPrice.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      wishListPro.deleteFromWishList(
                          wishListPro.wishListData[index].id.toString(), index);
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
