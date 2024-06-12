import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/screens/get_started_screen.dart';
import 'package:dekora/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/screens/change_address_screen.dart';
import 'package:dekora/screens/change_password_screen.dart';
import 'package:dekora/screens/about_dekora_screen.dart';
import 'package:dekora/screens/terms_and_condition_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables.primaryColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontFamily: 'Laviossa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/profile_pic.png'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? 'User Name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                            Text(
                              user?.email ?? 'user@example.com',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            // Edit profile action
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: GlobalVariables.primaryColor,
                    child: const Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  ),
                  ProfileMenuItem(
                    icon: Icons.home,
                    title: 'Your Address',
                    subtitle: 'Set your shipping address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeAddressScreen()),
                      );
                    },
                    backgroundColor: GlobalVariables.primaryColor,
                    textColor: Colors.white,
                    titleFontSize: 12,
                    subtitleFontSize: 12,
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock,
                    title: 'Account Security',
                    subtitle: 'Password, PIN, & Profile Verification',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen()),
                      );
                    },
                    backgroundColor: GlobalVariables.primaryColor,
                    textColor: Colors.white,
                    titleFontSize: 12,
                    subtitleFontSize: 12,
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: GlobalVariables.primaryColor,
                    child: const Text(
                      'About Dekora',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  ),
                  ProfileMenuItem(
                    icon: Icons.info,
                    title: 'Get to know Dekora',
                    subtitle: 'Details about Dekora App',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutDekoraScreen()),
                      );
                    },
                    backgroundColor: GlobalVariables.primaryColor,
                    textColor: Colors.white,
                    titleFontSize: 12,
                    subtitleFontSize: 12,
                  ),
                  ProfileMenuItem(
                    icon: Icons.description,
                    title: 'Terms & Condition',
                    subtitle: 'Terms and Condition applied on this app',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionsScreen()),
                      );
                    },
                    backgroundColor: GlobalVariables.primaryColor,
                    textColor: Colors.white,
                    titleFontSize: 12,
                    subtitleFontSize: 12,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: GlobalVariables.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Log out action
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Version 1.0.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double titleFontSize;
  final double subtitleFontSize;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.titleFontSize = 16,
    this.subtitleFontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontFamily: 'SF Pro Display',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: subtitleFontSize,
            color: textColor,
            fontFamily: 'SF Pro Display',
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
