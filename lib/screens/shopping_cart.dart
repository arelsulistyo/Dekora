import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/widgets/custom_bottom_navigation_bar.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Map<String, dynamic>> cartItems = [
    {
      "image": "https://via.placeholder.com/150",
      "name": "Tulip Nice",
      "description": "Indoor | Medium",
      "price": 69201,
      "quantity": 1,
      "selected": true
    },
    {
      "image": "https://via.placeholder.com/150",
      "name": "Tulip Neh",
      "description": "Indoor | Medium",
      "price": 69201,
      "quantity": 1,
      "selected": true
    },
    {
      "image": "https://via.placeholder.com/150",
      "name": "Tulip Nier",
      "description": "Indoor | Medium",
      "price": 69201,
      "quantity": 1,
      "selected": true
    },
  ];
  int _selectedIndex = 1;
  bool _isCartUpdated = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
      _isCartUpdated = true;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
        _isCartUpdated = true;
      }
    });
  }

  void _toggleSelection(int index, bool? value) {
    setState(() {
      cartItems[index]['selected'] = value ?? false;
      _isCartUpdated = true;
    });
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      if (item['selected']) {
        total += item['price'] * item['quantity'];
      }
    }
    return total;
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Cart',
            style: TextStyle(
              color: GlobalVariables.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete all items from the cart?',
            style: TextStyle(color: GlobalVariables.primaryColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: GlobalVariables.primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: GlobalVariables.primaryColor),
              ),
              onPressed: () {
                setState(() {
                  cartItems.clear();
                  _isCartUpdated = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: 'Laviossa',
            fontSize: 28,
            color: GlobalVariables.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: GlobalVariables.primaryColor),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: GlobalVariables.primaryColor),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: GlobalVariables.primaryColor,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: Checkbox(
                      value: item['selected'],
                      onChanged: (bool? value) {
                        _toggleSelection(index, value);
                      },
                      activeColor: GlobalVariables.primaryColor,
                    ),
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                color: GlobalVariables.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['description'],
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Rp${item['price']}',
                              style: const TextStyle(
                                color: GlobalVariables.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove,
                              color: GlobalVariables.primaryColor),
                          onPressed: () => _decrementQuantity(index),
                        ),
                        Text(
                          item['quantity'].toString(),
                          style: const TextStyle(
                              color: GlobalVariables.primaryColor),
                        ),
                        IconButton(
                          icon: Icon(Icons.add,
                              color: GlobalVariables.primaryColor),
                          onPressed: () => _incrementQuantity(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: GlobalVariables.primaryColor,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      Text(
                        'Rp${_calculateTotalPrice().toStringAsFixed(3)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: GlobalVariables.primaryColor,
                        ),
                        onPressed: _showDeleteConfirmationDialog,
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isCartUpdated = false;
                          });
                        },
                        child: Text(
                          _isCartUpdated ? 'Update Cart' : 'Checkout',
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isCartUpdated
                              ? Colors.pink
                              : GlobalVariables.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height:
                  70), // Add this SizedBox to add space above the bottom navigation bar
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}
