import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isDimmed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isDimmed = true;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/get_started');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dimming Overlay
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color:
                _isDimmed ? Colors.black.withOpacity(0.7) : Colors.transparent,
          ),
          // Text Widgets
          Center(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                _isDimmed ? Colors.black.withOpacity(0.7) : Colors.transparent,
                BlendMode.srcATop,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Dekora',
                    style: TextStyle(
                      fontFamily: 'Laviossa',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'flower rent',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
