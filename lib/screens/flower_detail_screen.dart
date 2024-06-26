import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/models/flower_model.dart';
import 'package:dekora/services/cart_service.dart';
import 'package:dekora/models/cart_item_model.dart';
import 'checkout_screen.dart';
import 'home_screen.dart'; // Import HomeScreen to navigate back

class FlowerDetailScreen extends StatelessWidget {
  final Flower flower;

  const FlowerDetailScreen({super.key, required this.flower});

  void _showBottomSheet(BuildContext context, bool isRentNow) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int quantity = 1;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: GlobalVariables.secondaryColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        flower.imageUrl,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp${flower.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.primaryColor,
                            ),
                          ),
                          Text(
                            'Stock: ${flower.stock}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isRentNow) {
                            Navigator.pop(context);
                            CartItem cartItem = CartItem(
                              id: flower.id,
                              flowerId: flower.id, // Add flowerId here
                              name: flower.name,
                              imageUrl: flower.imageUrl,
                              description: flower.description,
                              price: flower.price,
                              quantity: quantity,
                              selected: true,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  selectedItems: [cartItem],
                                ),
                              ),
                            );
                          } else {
                            try {
                              await CartService.addItemToCart(
                                  flower.id, quantity);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item added to cart!'),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            } catch (e) {
                              print('Failed to add to cart: $e');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isRentNow ? 'Rent Now' : 'Add to Cart',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables.primaryColor),
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
                          child: Image.network(
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
                            'Rp${flower.price.toStringAsFixed(2)}',
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
                    onPressed: () => _showBottomSheet(context, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Icon(Icons.add_shopping_cart,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16), // Space between buttons
                Expanded(
                  child: SizedBox(
                    height: 50, // Ensures both buttons have the same height
                    child: ElevatedButton(
                      onPressed: () => _showBottomSheet(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Rent Now',
                        style: TextStyle(
                          fontSize: 16,
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
