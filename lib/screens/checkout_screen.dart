import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/models/cart_item_model.dart';
import 'payment_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> selectedItems;

  const CheckoutScreen({
    super.key,
    required this.selectedItems,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool productProtection = false;
  bool isLoading = false;
  String selectedShipping = 'Economic';

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in widget.selectedItems) {
      total += item.price * item.quantity;
    }
    return total;
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

    double totalPayment = _calculateTotalPrice() + servicesFee + shippingCost;
    if (productProtection) {
      totalPayment += productProtectionCost * widget.selectedItems.length;
    }

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
                      ...widget.selectedItems.map((item) => Row(
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
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalVariables.primaryColor,
                                      fontFamily: 'SF Pro Display',
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
                                          fontFamily: 'SF Pro Display',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'x${item.quantity}',
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
                          )),
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
                              '\$${productProtectionCost.toStringAsFixed(2)} x${widget.selectedItems.length}',
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
                      RadioListTile<String>(
                        title: const Text(
                          'Economic',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '7 Days Arrival Guarantee',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'SF Pro Display'),
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Regular',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '4 Days Arrival Guarantee',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'SF Pro Display'),
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
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        activeColor: GlobalVariables.primaryColor,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          'Express',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'SF Pro Display'),
                        ),
                        subtitle: const Text(
                          '2 Days Arrival Guarantee',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'SF Pro Display'),
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
                            fontFamily: 'SF Pro Display',
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
                          'Rp${_calculateTotalPrice().toStringAsFixed(2)}',
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
                          '\$${shippingCost.toStringAsFixed(2)}',
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
                            '\$${(productProtectionCost * widget.selectedItems.length).toStringAsFixed(2)}',
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
                          'Rp${totalPayment.toStringAsFixed(2)}',
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
                                  builder: (context) =>
                                      const PaymentSuccessScreen(),
                                ),
                              );
                            });
                          },
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
