// flower_detail_screen.dart
import 'package:dekora/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:dekora/models/flower_model.dart';

class FlowerDetailScreen extends StatelessWidget {
  final Flower flower;

  const FlowerDetailScreen({super.key, required this.flower});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left, color: GlobalVariables.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontSize: 16,
            fontFamily: 'Laviossa',
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: GlobalVariables.secondaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            flower.imageUrl,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          Text(
                            '\$${flower.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: GlobalVariables.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          Text(
                            flower.type,
                            style: const TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'SF Pro Display',

                            ),
                          ),
                          Text(
                            flower.size,
                            style: const TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF Pro Display',

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    flower.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.primaryColor,
                              fontFamily: 'SF Pro Display',

                    ),
                  ),
                  const SizedBox(
                      height: 20), // Adjusted gap between title and description
                  Text(
                    flower.description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: GlobalVariables.primaryColor,
                          fontFamily: 'SF Pro Display',
                      height: 1.2, // Reduced line height
                    ),
                  ),
                  const SizedBox(height: 20), // Adjusted space for content
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50, // Ensures both buttons have the same height
                  width: 60, // Set a fixed width for the add to cart button
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add to cart button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Icon(Icons.add_shopping_cart, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16), // Space between buttons
                Expanded(
                  child: SizedBox(
                    height: 50, // Ensures both buttons have the same height
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle rent now button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Rent Now',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro Display',
                        ),
                      ), // Increased font size for button text
                    ),
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
