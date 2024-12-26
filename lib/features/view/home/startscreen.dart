import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pets_shop/features/controllers/home_providers/product_provider.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation - 1733477758555 (2).json'),
            const SizedBox(height: 20),
            Text(
              'Where Happy Tails Begin',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
            ),
            Consumer<ProductsProvider>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (provider.checkNetwork() == false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('No Internet Connection')));
                    } else {
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(192, 200, 30, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
