import 'package:dekora/screens/payment_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/services/transaction_service.dart';
import 'package:dekora/models/cart_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'payment_success_screen.dart'; // Import the new payment success screen
import 'payment_webview_screen.dart'; // Import the new payment webview screen

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> selectedItems;

  const CheckoutScreen({super.key, required this.selectedItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool productProtection = false;
  bool isLoading = false;
  String selectedShipping = 'Economic';
  String shippingAddress = 'User Shipping Address'; // Collect from user
  String paymentMethod =
      'gopay'; // Midtrans Snap supports multiple payment methods

  double _calculateTotalPayment() {
    double productProtectionCost = 1.13;
    double economicShippingCost = 1.0;
    double regularShippingCost = 3.14;
    double expressShippingCost = 6.02;
    double servicesFee = 0.5;

    double shippingCost = economicShippingCost;
    if (selectedShipping == 'Regular') {
      shippingCost = regularShippingCost;
    } else if (selectedShipping == 'Express') {
      shippingCost = expressShippingCost;
    }

    double totalPayment = widget.selectedItems
            .fold(0.0, (sum, item) => sum + item.price * item.quantity) +
        servicesFee +
        shippingCost;
    if (productProtection) {
      totalPayment += productProtectionCost * widget.selectedItems.length;
    }

    return totalPayment.roundToDouble();
  }

  void _payNow() async {
    setState(() {
      isLoading = true;
    });

    double totalPayment = _calculateTotalPayment();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final transaction = {
          'userId': user.uid,
          'items': widget.selectedItems
              .map((item) => {
                    'flowerId': item.flowerId,
                    'name': item.name,
                    'imageUrl': item.imageUrl,
                    'description': item.description,
                    'price': item.price,
                    'quantity': item.quantity,
                  })
              .toList(),
          'totalAmount': totalPayment.toInt(), // Convert to integer
          'shippingAddress': shippingAddress,
          'paymentMethod': paymentMethod,
          'shippingMethod': selectedShipping,
          'productProtection': productProtection,
        };

        final snapToken =
            await TransactionService.createTransaction(transaction);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebView(snapToken: snapToken),
          ),
        );
      }
    } catch (e) {
      print('Failed to create transaction: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to create transaction'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double productProtectionCost = 1.13;
    double economicShippingCost = 1.0;
    double regularShippingCost = 3.14;
    double expressShippingCost = 6.02;
    double servicesFee = 0.5;

    double shippingCost = economicShippingCost;
    if (selectedShipping == 'Regular') {
      shippingCost = regularShippingCost;
    } else if (selectedShipping == 'Express') {
      shippingCost = expressShippingCost;
    }

    double totalPayment = _calculateTotalPayment();

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
          'Checkout',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontSize: 16,
            fontFamily: 'Laviossa',
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display selected items
                      ...widget.selectedItems.map((item) {
                        return Row(
                          children: [
                            Image.network(
                              item.imageUrl,
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalVariables.primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: GlobalVariables.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'x${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            productProtection = !productProtection;
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: productProtection,
                              onChanged: (value) {
                                setState(() {
                                  productProtection = value!;
                                });
                              },
                              activeColor: GlobalVariables.primaryColor,
                            ),
                            const Text(
                              'Product Protection',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${productProtectionCost.toStringAsFixed(2)} x${widget.selectedItems.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: GlobalVariables.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Shipping Option',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RadioListTile<String>(
                        title: const Text(
                          'Economic',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: const Text(
                          '7 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: 'Economic',
                        groupValue: selectedShipping,
                        onChanged: (value) {
                          setState(() {
                            selectedShipping = value!;
                          });
                        },
                        secondary: Text(
                          '\$${economicShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Regular',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: const Text(
                          '4 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: 'Regular',
                        groupValue: selectedShipping,
                        onChanged: (value) {
                          setState(() {
                            selectedShipping = value!;
                          });
                        },
                        secondary: Text(
                          '\$${regularShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Express',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: const Text(
                          '2 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: 'Express',
                        groupValue: selectedShipping,
                        onChanged: (value) {
                          setState(() {
                            selectedShipping = value!;
                          });
                        },
                        secondary: Text(
                          '\$${expressShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_balance_wallet,
                            color: GlobalVariables.primaryColor),
                        SizedBox(width: 8),
                        Text(
                          'Payment Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Subtotal For Product',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${widget.selectedItems.fold(0.0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Subtotal For Shipment',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${shippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    if (productProtection)
                      Row(
                        children: [
                          const Text(
                            'Subtotal For Protection',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${(productProtectionCost * widget.selectedItems.length).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: GlobalVariables.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        const Text(
                          'Services Fee',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${servicesFee.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Total Payment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${totalPayment.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _payNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading)
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
    );
  }
}
