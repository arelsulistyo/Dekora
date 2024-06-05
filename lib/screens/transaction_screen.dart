import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/widgets/custom_bottom_navigation_bar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> transactions = [
    {
      "date": "2 Juni 2024",
      "status": "Finished",
      "statusColor": Colors.green,
      "image": "https://via.placeholder.com/50",
      "name": "Tulip Nigga 8818",
      "quantity": 25,
      "totalPurchase": "Rp. 888888888"
    },
    {
      "date": "1 Juni 2024",
      "status": "In Progress",
      "statusColor": Colors.yellow,
      "image": "https://via.placeholder.com/50",
      "name": "Rose Bud 1234",
      "quantity": 10,
      "totalPurchase": "Rp. 50000000"
    },
    {
      "date": "31 Mei 2024",
      "status": "Not Done",
      "statusColor": Colors.red,
      "image": "https://via.placeholder.com/50",
      "name": "Lily Blossom 5678",
      "quantity": 5,
      "totalPurchase": "Rp. 25000000"
    },
    {
      "date": "30 Mei 2024",
      "status": "Finished",
      "statusColor": Colors.green,
      "image": "https://via.placeholder.com/50",
      "name": "Daisy Delight 91011",
      "quantity": 15,
      "totalPurchase": "Rp. 75000000"
    },
  ];
  List<Map<String, dynamic>> filteredTransactions = [];
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;
    searchController.addListener(() {
      filterTransactions();
    });
  }

  void filterTransactions() {
    List<Map<String, dynamic>> _transactions = [];
    _transactions.addAll(transactions);
    if (searchController.text.isNotEmpty) {
      _transactions.retainWhere((transaction) {
        String searchTerm = searchController.text.toLowerCase();
        String transactionName = transaction["name"].toLowerCase();
        return transactionName.contains(searchTerm);
      });
    }
    setState(() {
      filteredTransactions = _transactions;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon:
                        Icon(Icons.search, color: GlobalVariables.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Transactions',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: GlobalVariables.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle transaction tap
                        },
                        child: Container(
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
                                          'Purchase\n${transaction["date"]}',
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
                                        color: transaction["statusColor"],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        transaction["status"],
                                        style: const TextStyle(
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
                                      transaction["image"],
                                      width: 50,
                                      height: 50,
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction["name"],
                                          style: const TextStyle(
                                            fontFamily: 'SF Pro Display',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${transaction["quantity"]} items',
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
                                          transaction["totalPurchase"],
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
                                        // Handle buy again action
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            GlobalVariables.secondaryColor,
                                      ),
                                      child: Text(
                                        'Buy Again',
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              // onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
