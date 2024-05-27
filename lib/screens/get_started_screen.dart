import 'package:dekora/global_variables.dart';
import 'package:dekora/screens/login_screen.dart';
import 'package:dekora/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/get_started_bg.png'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0), // Add horizontal padding
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical:
                        5.0), // Add horizontal padding and vertical padding
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    'Let\'s get your flowers ready!',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 20,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0), // Add horizontal padding
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Login Page
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0), // Add horizontal padding
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: GlobalVariables.primaryColor,
                      side:
                          const BorderSide(color: GlobalVariables.primaryColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
