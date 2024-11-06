import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomedserv/providers/auth.dart';
import 'package:gomedserv/providers/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create TextEditingControllers for username and password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create a GlobalKey for the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity, // Full width
              height: MediaQuery.of(context).size.height *
                  0.65, // Adjust this as needed
              decoration: BoxDecoration(
                color: const Color(0xFFD2F1E4), // Container background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      screenWidth * 0.7), // Scaled top-left radius
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Form(
                    key: _formKey, // Attach the form key
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Username',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),

                              // Username Field
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0),

                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),

                              // Password Field
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  obscureText: true, // For hiding the password
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0),

                              // Login Button
                              Consumer(
                                builder: (context, ref, child) {
                                  var auth = ref.read(authProvider.notifier);
                                  var loader = ref.watch(loadingProvider);
                                  return SizedBox(
                                    width: screenWidth * 0.8,
                                    child: ElevatedButton(
                                      onPressed: loader == true
                                          ? null
                                          : () {
                                              // Validate form fields
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                auth.adminLogin(
                                                  ref,
                                                  username:
                                                      _usernameController.text,
                                                  password:
                                                      _passwordController.text,
                                                );
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: loader == true
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Additional Links
                              const SizedBox(height: 10.0),

                              GestureDetector(
                                onTap: () {
                                  // Handle "Have trouble?" action
                                },
                                child: const Text(
                                  'Have trouble? click here',
                                  style: TextStyle(
                                    color: Colors.teal,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
