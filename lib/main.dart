// main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/get_started_screen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart'; // Import the profile screen

void main() {
  runApp(const DekoraApp());
}

class DekoraApp extends StatelessWidget {
  const DekoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dekora Flower Rent',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/get_started': (context) => const GetStartedScreen(),
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
