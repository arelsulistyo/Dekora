import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/screens/order_details.dart'; // Add this import
import 'package:dekora/models/transaction_model.dart';
import 'package:dekora/widgets/custom_bottom_navigation_bar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> transactions = [];
  bool isLoading = true;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  void fetchTransactions() {
    // Dummy data for transactions
    setState(() {
      transactions = [
        Transaction(
          id: '1',
          userId: 'user1',
          items: [
            Item(
              flowerId: 'flower1',
              name: 'Tulip Nigga 8818',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Beautiful tulips',
              price: 20.0,
              quantity: 25,
            ),
            Item(
              flowerId: 'flower2',
              name: 'Rose Paradise',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Beautiful roses',
              price: 30.0,
              quantity: 15,
            ),
            Item(
              flowerId: 'flower3',
              name: 'Sunflower Delight',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Bright sunflowers',
              price: 25.0,
              quantity: 10,
            ),
            Item(
              flowerId: 'flower4',
              name: 'Lily Elegance',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Elegant lilies',
              price: 28.0,
              quantity: 20,
            ),
            Item(
              flowerId: 'flower5',
              name: 'Daisy Dream',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Dreamy daisies',
              price: 15.0,
              quantity: 30,
            ),
          ],
          totalAmount: 88888888.0,
          shippingAddress: '3517 W. Gray St. Utica, Pennsylvania 57867',
          paymentMethod: 'Credit Card',
          shippingMethod: 'Courier',
          productProtection: true,
          date: DateTime.now(),
        ),
        Transaction(
          id: '2',
          userId: 'user2',
          items: [
            Item(
              flowerId: 'flower6',
              name: 'Orchid Oasis',
              imageUrl: 'https://via.placeholder.com/150',
              description: 'Orchid flowers',
              price: 40.0,
              quantity: 12,
            ),
          ],
          totalAmount: 48000000.0,
          shippingAddress: '123 Main St, New York, NY 10001',
          paymentMethod: 'PayPal',
          shippingMethod: 'Courier',
          productProtection: false,
          date: DateTime.now().subtract(Duration(days: 1)),
        ),
        // Add more dummy transactions as needed
      ];
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : transactions.isEmpty
              ? const Center(child: Text('No transactions found'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: GlobalVariables.primaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.shopping_bag,
                                          color: Colors.white),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Purchase\n${transaction.date.toLocal()}'
                                            .split(' ')[0],
                                        style: const TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(color: Colors.white),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.network(
                                    transaction.items.first.imageUrl,
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.items.first.name,
                                        style: const TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${transaction.items.length} items',
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
                                          fontFamily: 'SF Pro Display',
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${transaction.totalAmount}',
                                        style: const TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailsScreen(
                                            transaction: transaction,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          GlobalVariables.secondaryColor,
                                    ),
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        color: GlobalVariables.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}
