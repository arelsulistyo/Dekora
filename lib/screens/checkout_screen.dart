import 'package:dekora/screens/change_address_screen.dart';
import 'package:dekora/screens/payment_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/services/transaction_service.dart';
import 'package:dekora/models/cart_item_model.dart';
import 'payment_success_screen.dart';
import 'package:dekora/screens/change_address_screen.dart'; // Import the EditAddressScreen
import 'package:firebase_auth/firebase_auth.dart';
import 'payment_success_screen.dart'; // Import the new payment success screen
 // Import the new payment webview screen

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

  String recipientName = '';
  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  String postalCode = '';
  String paymentMethod = 'Credit Card';

  @override
  void initState() {
    super.initState();
    _loadRecipientDetails();
  }

  Future<void> _loadRecipientDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          setState(() {
            recipientName = doc.data()?['name'] ?? '';
            addressLine1 = doc.data()?['addressLine1'] ?? '';
            addressLine2 = doc.data()?['addressLine2'] ?? '';
            city = doc.data()?['city'] ?? '';
            postalCode = doc.data()?['postalCode'] ?? '';
          });
        }

        // Check if recipient details are missing
        if (recipientName.isEmpty ||
            addressLine1.isEmpty ||
            city.isEmpty ||
            postalCode.isEmpty) {
          _navigateToEditAddressScreen();
        }
      }
    } catch (e) {
      print('Failed to load recipient details: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void _navigateToEditAddressScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const ChangeAddressScreen(), // Make sure this screen exists
      ),
    );
  }

  Future<void> _updateRecipientDetails(
      String newRecipientName,
      String newAddressLine1,
      String newAddressLine2,
      String newCity,
      String newPostalCode) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': newRecipientName,
        'addressLine1': newAddressLine1,
        'addressLine2': newAddressLine2,
        'city': newCity,
        'postalCode': newPostalCode,
      });
    }
    setState(() {
      recipientName = newRecipientName;
      addressLine1 = newAddressLine1;
      addressLine2 = newAddressLine2;
      city = newCity;
      postalCode = newPostalCode;
    });
  }

  String shippingAddress = 'User Shipping Address'; // Collect from user
  String paymentMethod =
      'gopay'; // Midtrans Snap supports multiple payment methods


  double _calculateTotalPayment() {
    double productProtectionCost = 1500;
    double economicShippingCost = 1000;
    double regularShippingCost = 3000;
    double expressShippingCost = 6000;
    double servicesFee = 1000;

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
    if (recipientName.isEmpty ||
        addressLine1.isEmpty ||
        city.isEmpty ||
        postalCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Please provide complete recipient and address details'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    double totalPayment = _calculateTotalPayment();
    String shippingAddress = '$addressLine1, $addressLine2, $city, $postalCode';

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


          'recipientName': recipientName,

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
    double productProtectionCost = 1500;
    double economicShippingCost = 1000;
    double regularShippingCost = 3000;
    double expressShippingCost = 6000;
    double servicesFee = 1000;

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
                                      'Rp${item.price.toStringAsFixed(2)}',
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
                              'Rp ${productProtectionCost.toStringAsFixed(2)} x${widget.selectedItems.length}',
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
                          'Rp ${economicShippingCost.toStringAsFixed(2)}',
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
                          'Rp${regularShippingCost.toStringAsFixed(2)}',
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
                          'Rp${expressShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recipient Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              color: GlobalVariables.primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            recipientName.isNotEmpty
                                ? recipientName
                                : 'Recipient name not set',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              // Show dialog to edit recipient details
                              final result =
                                  await showDialog<Map<String, String>>(
                                context: context,
                                builder: (context) {
                                  final recipientNameController =
                                      TextEditingController(
                                          text: recipientName);
                                  final addressLine1Controller =
                                      TextEditingController(text: addressLine1);
                                  final addressLine2Controller =
                                      TextEditingController(text: addressLine2);
                                  final cityController =
                                      TextEditingController(text: city);
                                  final postalCodeController =
                                      TextEditingController(text: postalCode);
                                  return AlertDialog(
                                    title: const Text('Edit Recipient Details'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: recipientNameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Recipient Name'),
                                        ),
                                        TextField(
                                          controller: addressLine1Controller,
                                          decoration: const InputDecoration(
                                              labelText: 'Address Line 1'),
                                        ),
                                        TextField(
                                          controller: addressLine2Controller,
                                          decoration: const InputDecoration(
                                              labelText: 'Address Line 2'),
                                        ),
                                        TextField(
                                          controller: cityController,
                                          decoration: const InputDecoration(
                                              labelText: 'City'),
                                        ),
                                        TextField(
                                          controller: postalCodeController,
                                          decoration: const InputDecoration(
                                              labelText: 'Postal Code'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop({
                                            'recipientName':
                                                recipientNameController.text,
                                            'addressLine1':
                                                addressLine1Controller.text,
                                            'addressLine2':
                                                addressLine2Controller.text,
                                            'city': cityController.text,
                                            'postalCode':
                                                postalCodeController.text,
                                          });
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (result != null) {
                                await _updateRecipientDetails(
                                    result['recipientName']!,
                                    result['addressLine1']!,
                                    result['addressLine2']!,
                                    result['city']!,
                                    result['postalCode']!);
                              }
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: GlobalVariables.primaryColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              addressLine1.isNotEmpty
                                  ? '$addressLine1, $addressLine2, $city, $postalCode'
                                  : 'Address not set',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
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
                          'Rp${widget.selectedItems.fold(0.0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}',
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
                          'Rp${shippingCost.toStringAsFixed(2)}',
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
                            'Rp${(productProtectionCost * widget.selectedItems.length).toStringAsFixed(2)}',
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
                          'Rp${servicesFee.toStringAsFixed(2)}',
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
                          'Rp${totalPayment.toStringAsFixed(2)}',
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
