import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalVariables.primaryColor, // Set the background color of the bar
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3), // Shadow above the container
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
              height: 80, // Set the desired height of the bar
              child: BottomNavigationBar(
                backgroundColor: GlobalVariables.primaryColor, // Solid background color
                currentIndex: selectedIndex,
                onTap: onItemTapped,
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
                    label: 'Search',
                    isSelected: selectedIndex == 2,
                  ),
                  _buildBottomNavigationBarItem(
                    icon: Icons.person,
                    label: 'Profile',
                    isSelected: selectedIndex == 3,
                  ),
                ],
                selectedItemColor: Colors.white, // Ensure the selected item color stands out on the primary color
                unselectedItemColor: Colors.white.withOpacity(0.7), // Slightly transparent unselected items
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
              color: Colors.white, // Color of the horizontal bar indicator
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
