import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pets_shop/features/view/login/admin_login.dart';
import 'package:provider/provider.dart';
import 'package:pets_shop/features/controllers/authentication_providers/login_provider.dart';
import 'package:pets_shop/features/view/home/home.dart';
import 'package:pets_shop/features/view/signup/sign_up.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset(
                  'assets/Animation - 1733479621168.json',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 253, 240, 222),
                  ),
                  child: Consumer<LoginProvider>(
                    builder: (context, loginProvider, _) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'Welcome',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Sign in to continue',
                                style: GoogleFonts.poppins(fontSize: 15)),
                            const SizedBox(height: 15),
                            // Username Field
                            TextFormField(
                              controller: usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter your username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            // Password Field
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            // Sign-In Button
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(5),
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.red),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() == true) {
                                  final username =
                                      usernameController.text.trim();
                                  final password =
                                      passwordController.text.trim();

                                  final loginSuccess = await loginProvider
                                      .login(username, password);

                                  if (loginSuccess) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Login failed. Please try again.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: loginProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(5),
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.red),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Create an Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return AdminLogin();
                                    },
                                    transitionDuration: Duration(seconds: 0),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Are you a Admin? Log in Here",
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
