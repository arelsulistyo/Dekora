// custom_bottom_navigation_bar.dart
import 'package:dekora/screens/home_screen.dart';
import 'package:dekora/screens/profile_screen.dart';
import 'package:dekora/screens/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    String routeName;
    switch (index) {
      case 0:
        routeName = '/home';
        break;
      case 1:
        // Add navigation to the Shop screen if implemented
        return;
      case 2:
        routeName = '/transaction'; // Add navigation to the Transaction screen
        break;
      case 3:
        routeName = '/profile';
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getRoutePage(routeName),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 10.0;
          const curve = Curves.easeInOut;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final fadeAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget _getRoutePage(String routeName) {
    switch (routeName) {
      case '/home':
        return const HomeScreen();
      case '/profile':
        return const ProfileScreen();
      case '/transaction':
        return const TransactionScreen(); // Return the TransactionScreen
      default:
        return const HomeScreen(); // Default to home if route not found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalVariables.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                backgroundColor: GlobalVariables.primaryColor,
                currentIndex: selectedIndex,
                onTap: (index) => _onItemTapped(context, index),
                items: [
                  _buildBottomNavigationBarItem(
                    icon: Icons.home,
                    label: 'Home',
                    isSelected: selectedIndex == 0,
                  ),
                  _buildBottomNavigationBarItem(
                    icon: Icons.shop,
                    label: 'Shop',
                    isSelected: selectedIndex == 1,
                  ),
                  _buildBottomNavigationBarItem(
                    icon: Icons.search,
                    label: 'Transaction',
                    isSelected: selectedIndex == 2,
                  ),
                  _buildBottomNavigationBarItem(
                    icon: Icons.person,
                    label: 'Profile',
                    isSelected: selectedIndex == 3,
                  ),
                ],
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.7),
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width / 4) * selectedIndex,
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
