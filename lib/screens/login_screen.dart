import 'package:dekora/global_variables.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Background color to match the target design
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables
                  .primaryColor), // Change the icon color to white
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        backgroundColor:
            GlobalVariables.secondaryColor, // Red color for the AppBar
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/login_bg.png'), // Replace with your image path
                fit: BoxFit.fitWidth,
                alignment:
                    Alignment.bottomCenter, // Align the image to the bottom
              ),
            ),
          ),
          const SizedBox(
              height: 20), // Adjusted space between the top container and form

          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: GlobalVariables
                      .secondaryColor, // Red color for the container
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0), // Reduced height to minimize the gap
                    Text(
                      'Log in',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 32, // Adjusted size to match target design
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables
                            .primaryColor, // White color for the text
                      ),
                    ),
                    Text(
                      'to use the application!',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: GlobalVariables
                            .primaryColor, // White color for the text
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      120), // Adjusted space between the top container and form
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: GlobalVariables
                      .secondaryColor, // Light pink color for the container
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 32, // Adjusted size to match target design
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontFamily: 'SF Pro Display',

                          color: GlobalVariables
                              .primaryColor, // Red color for the label
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: GlobalVariables
                                  .primaryColor), // Red color for the focused border
                        ),
                        border:
                            UnderlineInputBorder(), // Underline border to match target design
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'SF Pro Display',

                          color: GlobalVariables
                              .primaryColor, // Red color for the label
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: GlobalVariables
                                  .primaryColor), // Red color for the focused border
                        ),
                        border:
                            UnderlineInputBorder(), // Underline border to match target design
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                      child: Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: GlobalVariables
                                  .primaryColor, // Red color for the checkbox
                            ),
                            child: Checkbox(
                              value: _rememberMe,
                              checkColor: Colors.white,
                              activeColor: GlobalVariables.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily:
                                  'SF Pro Display', // Ensuring consistent font
                              color: GlobalVariables
                                  .primaryColor, // Red color for the text
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.bold,
                                color: GlobalVariables
                                    .primaryColor, // Red color for the text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(builder: (context) => NewPage()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables
                              .primaryColor, // Red color for the button
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
