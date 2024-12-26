import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shop/features/controllers/authentication_providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 20,
          ),
          child: Column(
            children: [
              Text(
                "Create Account",
                style: GoogleFonts.poppins(fontSize: 30, color: Colors.red),
              ),
              Text(
                "Great news - by creating an account, you'll join our Pets Club, unlocking exclusive offers for your pet, including 10% off when you first sign up. If you're already a member, your Pets Club benefits will be waiting for you.",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 199, 157, 157),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(10),
                height: 490,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 253, 240, 222),
                ),
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, _) => Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Full name',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Username',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (authProvider.isLoading)
                          const CircularProgressIndicator(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              authProvider.signUp(
                                username: usernameController.text,
                                password: passwordController.text,
                                email: emailController.text,
                                name: nameController.text,
                              );
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Invalid credentials')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(192, 200, 30, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (authProvider.errorMessage != null)
                          Text(
                            authProvider.errorMessage!,
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 15),
                          ),
                        if (authProvider.user != null)
                          Text(
                            'Sign up successful',
                            style: GoogleFonts.poppins(
                                color: Colors.green, fontSize: 15),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
