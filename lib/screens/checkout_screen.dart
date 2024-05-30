// checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'payment_success_screen.dart'; // Import the new payment success screen

class CheckoutScreen extends StatefulWidget {
  final String flowerName;
  final double price;
  final int quantity;

  const CheckoutScreen({
    super.key,
    required this.flowerName,
    required this.price,
    required this.quantity,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool productProtection = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double productProtectionCost = 1.13;
    double economicShippingCost = 1.0;
    double regularShippingCost = 3.14;
    double expressShippingCost = 6.02;
    double servicesFee = 0.5;

    double totalPayment = widget.price * widget.quantity + servicesFee + economicShippingCost;
    if (productProtection) {
      totalPayment += productProtectionCost * widget.quantity;
    }

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
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/flower1.png', // Update this to the correct asset path
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.flowerName,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: GlobalVariables.primaryColor,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$${widget.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: GlobalVariables.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'x${widget.quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${productProtectionCost.toStringAsFixed(2)} x${widget.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: GlobalVariables.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SF Pro Display',
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
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text(
                          'Economic',
                          style: TextStyle(fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '7 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12, fontFamily: 'SF Pro Display'),
                        ),
                        trailing: Text(
                          '\$${economicShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Regular',
                          style: TextStyle(fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '4 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12, fontFamily: 'SF Pro Display'),
                        ),
                        trailing: Text(
                          '\$${regularShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Express',
                          style: TextStyle(fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '2 Days Arrival Guarantee',
                          style: TextStyle(fontSize: 12, fontFamily: 'SF Pro Display'),
                        ),
                        trailing: Text(
                          '\$${expressShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
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
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: GlobalVariables.primaryColor),
                        const SizedBox(width: 8),
                        const Text(
                          'Payment Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Display',
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${(widget.price * widget.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${economicShippingCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
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
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${(productProtectionCost * widget.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: GlobalVariables.primaryColor,
                              fontFamily: 'SF Pro Display',
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${servicesFee.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${totalPayment.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentSuccessScreen(),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
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
