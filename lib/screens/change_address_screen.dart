import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'edit_address_screen.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  String currentAddress = "Suite 576 36978 Fabian Plain, Browntown, IN 74890";
  String name = "Sena";
  String phoneNumber = "08888888888";
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        titleSpacing: 0,
        title: const Text(
          'Change Address',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontFamily: 'Laviossa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: GlobalVariables
                          .primaryColor, // Secondary primary color
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'This is my address',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          currentAddress,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAddressScreen(
                                    name: name,
                                    phoneNumber: phoneNumber,
                                    addressLine1: currentAddress.split(',')[0],
                                    addressLine2: currentAddress
                                        .split(',')
                                        .skip(1)
                                        .join(',')
                                        .trim(),
                                    city:
                                        'Browntown', // Dummy city for demo purposes
                                    postalCode:
                                        '74890', // Dummy postal code for demo purposes
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  name = result['name'];
                                  phoneNumber = result['phoneNumber'];
                                  currentAddress =
                                      '${result['addressLine1']}, ${result['addressLine2']}, ${result['city']}, ${result['postalCode']}';
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Change Address Details',
                              style: TextStyle(
                                color: GlobalVariables.primaryColor,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: GlobalVariables.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Log out action
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Version 1.0.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF Pro Display',
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
