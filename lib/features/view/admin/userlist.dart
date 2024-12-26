import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shop/features/controllers/admin_side/user_provider.dart';
import 'package:provider/provider.dart';

class AdminUserList extends StatefulWidget {
  const AdminUserList({super.key});

  @override
  State<AdminUserList> createState() => _AdminUserListState();
}

class _AdminUserListState extends State<AdminUserList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UserManagementProvider>(context, listen: false).getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Admin User List',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Consumer<UserManagementProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(userProvider.errorMessage));
          }
          if (userProvider.users.isEmpty) {
            return const Center(child: Text('No Users available'));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 5,
                child: Column(
                  children: [
                    Text(
                      userProvider.users[index].name!,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                    Text(
                      userProvider.users[index].email!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userProvider.users[index].sId!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userProvider.users[index].wishlist.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: userProvider.users.length,
          );
        },
      ),
    );
  }
}
