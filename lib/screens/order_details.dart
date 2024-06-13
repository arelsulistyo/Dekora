import 'package:flutter/material.dart';
import 'package:dekora/models/transaction_model.dart';
import 'package:dekora/global_variables.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Transaction transaction;

  const OrderDetailsScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool showMoreItems = false;

  double get subtotalForProduct => widget.transaction.items
      .map((item) => item.price * item.quantity)
      .reduce((value, element) => value + element);

  double get subtotalForShipment {
    switch (widget.transaction.shippingMethod) {
      case 'Economic':
        return 1000.0;
      case 'Regular':
        return 3000.0;
      case 'Express':
        return 6000.0;
      default:
        return 0.0; // Default value if shipping method is not recognized
    }
  }

  double get subtotalForProtection => widget.transaction.productProtection
      ? widget.transaction.items.length * 1500.0
      : 0.0;

  final double servicesFee = 1000.0;

  double get totalPayment =>
      subtotalForProduct +
      subtotalForShipment +
      subtotalForProtection +
      servicesFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontFamily: 'Laviossa',
            fontSize: 28,
            color: GlobalVariables.primaryColor,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: GlobalVariables.primaryColor,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: GlobalVariables.primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Order Finished\n${widget.transaction.date.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Image.network(
                            widget.transaction.items.first.imageUrl,
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.transaction.items.first.name,
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${widget.transaction.items.first.quantity} items',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Purchase',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Rp${widget.transaction.items.first.price * widget.transaction.items.first.quantity}',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMoreItems = !showMoreItems;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                showMoreItems
                                    ? 'Show less items'
                                    : '+${widget.transaction.items.length - 1} other items',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (showMoreItems)
                        Column(
                          children: widget.transaction.items
                              .skip(1)
                              .map((item) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: GlobalVariables.primaryColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              item.imageUrl,
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(width: 16),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '${item.quantity} items',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Divider(color: Colors.white),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Total Purchase',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Rp ${item.price * item.quantity}',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor,
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_shipping, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Payment Details',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person,
                              color: GlobalVariables.primaryColor),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Kurir',
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'GK-11-768098986',
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.transaction.shippingAddress,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.payment,
                            color: GlobalVariables.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Payment Summary',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: widget.transaction.items.map((item) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.name} x${item.quantity}',
                                  style: const TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    color: GlobalVariables.primaryColor,
                                  ),
                                ),
                                Text(
                                  'Rp ${item.price * item.quantity}',
                                  style: const TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    color: GlobalVariables.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      }).toList(),
                    ),
                    const Divider(color: GlobalVariables.primaryColor),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal For Product',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        Text(
                          'Rp $subtotalForProduct',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal For Shipment',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        Text(
                          'Rp $subtotalForShipment',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal For Protection',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        Text(
                          'Rp $subtotalForProtection',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Services Fee',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        Text(
                          'Rp $servicesFee',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: GlobalVariables.primaryColor),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        Text(
                          'Rp $totalPayment',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
