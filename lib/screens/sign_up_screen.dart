import 'dart:developer';

import 'package:dekora/screens/login_screen.dart'; // Import the LoginScreen
import 'package:dekora/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance; // Use FirebaseAuth instance

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _agreeToTerms = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isLoading = false; // Track the loading state

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms and Conditions'),
          content: const SingleChildScrollView(
            child: Text("""// Terms and Conditions content here..."""),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateEmail(String email) {
    if (!email.contains('@')) {
      setState(() {
        _emailError = 'Invalid email address';
      });
      return false;
    }
    setState(() {
      _emailError = null;
    });
    return true;
  }

  bool _validatePassword(String password) {
    if (password.length < 6) {
      setState(() {
        _passwordError = 'Must be at least 6 characters';
      });
      return false;
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      setState(() {
        _passwordError = 'Must contain at least one uppercase letter';
      });
      return false;
    }
    if (!RegExp(r'(?=.*[0-9])').hasMatch(password)) {
      setState(() {
        _passwordError = 'Must contain at least one number';
      });
      return false;
    }
    setState(() {
      _passwordError = null;
    });
    return true;
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      return false;
    }
    setState(() {
      _confirmPasswordError = null;
    });
    return true;
  }

  void _signup() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    bool isEmailValid = _validateEmail(email);
    bool isPasswordValid = _validatePassword(password);
    bool isConfirmPasswordValid =
        _validateConfirmPassword(password, confirmPassword);

    if (isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      setState(() {
        _isLoading = true; // Start loading
      });

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          log("User Created Successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'email-already-in-use') {
            _emailError = 'The email address is already in use.';
          } else if (e.code == 'weak-password') {
            _passwordError = 'The password provided is too weak.';
          } else {
            _emailError = e.message;
          }
        });
        log("Signup failed: ${e.message}");
      } finally {
        setState(() {
          _isLoading = false; // Stop loading after process finishes
        });
      }
    }
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup_bg.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: GlobalVariables.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor,
                      ),
                    ),
                    Text(
                      'to use the application!',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: GlobalVariables.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: GlobalVariables.secondaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: GlobalVariables.primaryColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.primaryColor),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: GlobalVariables.primaryColor,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.primaryColor),
                        ),
                        border: const UnderlineInputBorder(),
                        errorText: _emailError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: GlobalVariables.primaryColor,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.primaryColor),
                        ),
                        border: const UnderlineInputBorder(),
                        errorText: _passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: GlobalVariables.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: GlobalVariables.primaryColor,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.primaryColor),
                        ),
                        border: const UnderlineInputBorder(),
                        errorText: _confirmPasswordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: GlobalVariables.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: GlobalVariables.primaryColor,
                          ),
                          child: Checkbox(
                            value: _agreeToTerms,
                            checkColor: Colors.white,
                            activeColor: GlobalVariables.primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value!;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: _showTermsAndConditions,
                            child: RichText(
                              text: const TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  color: GlobalVariables.primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'terms and conditions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (_isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            GlobalVariables.primaryColor),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_agreeToTerms) {
                              _signup();
                            } else {
                              // Show a snackbar or dialog to accept terms
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'You need to accept terms and conditions to proceed'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () => _goToLogin(context),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'SF Pro Display',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
