import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/services/cart_service.dart';
import 'package:dekora/widgets/custom_bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:dekora/models/cart_item_model.dart';
import 'checkout_screen.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [];
  bool isLoading = true;
  bool _isCartUpdated = false;
  bool _isUpdating = false;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final items = await CartService.fetchCartItems();
      setState(() {
        cartItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load cart items: $e');
    }
  }

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      _isCartUpdated = true;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 0) {
        cartItems[index].quantity--;
        _isCartUpdated = true;
      }
    });
  }

  void _toggleSelection(int index, bool? value) {
    setState(() {
      cartItems[index].selected = value ?? false;
      _isCartUpdated = true;
    });
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      if (item.selected) {
        total += item.price * item.quantity;
      }
    }
    return total;
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price).replaceAll(',', '.');
  }

  void _updateCartItems() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      for (var item in cartItems) {
        await CartService.updateCartItem(item.flowerId, item.quantity);
      }
      setState(() {
        _isCartUpdated = false;
        _isUpdating = false;
      });
    } catch (e) {
      print('Failed to update cart items: $e');
      setState(() {
        _isUpdating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to update cart items'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Cart',
            style: TextStyle(
              color: GlobalVariables.primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro Display',
            ),
          ),
          content: const Text(
            'Are you sure you want to delete all items from the cart?',
            style: TextStyle(
              color: GlobalVariables.primaryColor,
              fontFamily: 'SF Pro Display',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _isUpdating = true;
                });
                try {
                  for (var item in cartItems) {
                    item.quantity = 0;
                    await CartService.updateCartItem(
                        item.flowerId, item.quantity);
                  }
                  await fetchCartItems();
                  setState(() {
                    _isCartUpdated = false;
                    _isUpdating = false;
                  });
                } catch (e) {
                  print('Failed to update cart items: $e');
                  setState(() {
                    _isUpdating = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Failed to update cart items'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _goToCheckout() {
    List<CartItem> selectedItems =
        cartItems.where((item) => item.selected).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(selectedItems: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dekora',
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: GlobalVariables.primaryColor,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cartItems.isEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalVariables.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Browse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8.0),
                                  leading: Checkbox(
                                    value: item.selected,
                                    onChanged: (bool? value) {
                                      _toggleSelection(index, value);
                                    },
                                    activeColor: GlobalVariables.primaryColor,
                                  ),
                                  title: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          item.imageUrl,
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              color:
                                                  GlobalVariables.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SF Pro Display',
                                            ),
                                          ),
                                          Text(
                                            item.description,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'SF Pro Display',
                                            ),
                                          ),
                                          Text(
                                            'Rp${_formatPrice(item.price.toDouble())}',
                                            style: const TextStyle(
                                              color:
                                                  GlobalVariables.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SF Pro Display',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _decrementQuantity(index),
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: GlobalVariables.primaryColor,
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _incrementQuantity(index),
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: GlobalVariables.primaryColor,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
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
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: GlobalVariables.primaryColor,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
              if (cartItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: GlobalVariables.primaryColor,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Rp${_formatPrice(_calculateTotalPrice())}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: GlobalVariables.primaryColor,
                              ),
                              onPressed: _showDeleteConfirmationDialog,
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _isCartUpdated
                                  ? _updateCartItems
                                  : _goToCheckout,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isCartUpdated
                                    ? Colors.white
                                    : GlobalVariables.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: _isCartUpdated
                                    ? const BorderSide(
                                        color: GlobalVariables.primaryColor,
                                        width: 2)
                                    : null,
                              ),
                              child: Text(
                                _isCartUpdated ? 'Update Cart' : 'Checkout',
                                style: TextStyle(
                                  color: _isCartUpdated
                                      ? GlobalVariables.primaryColor
                                      : Colors.white,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
          if (_isUpdating)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
