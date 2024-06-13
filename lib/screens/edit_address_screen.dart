import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/global_variables.dart';

class EditAddressScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String postalCode;

  EditAddressScreen({
    required this.name,
    required this.phoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
  });

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController cityController;
  late TextEditingController postalCodeController;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    addressLine1Controller = TextEditingController(text: widget.addressLine1);
    addressLine2Controller = TextEditingController(text: widget.addressLine2);
    cityController = TextEditingController(text: widget.city);
    postalCodeController = TextEditingController(text: widget.postalCode);
  }

  Future<void> _saveAddress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': nameController.text,
        'phoneNumber': phoneNumberController.text,
        'addressLine1': addressLine1Controller.text,
        'addressLine2': addressLine2Controller.text,
        'city': cityController.text,
        'postalCode': postalCodeController.text,
      }, SetOptions(merge: true));
    }
  }

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
          'Edit Address',
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
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Recipient Name',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: addressLine1Controller,
                    decoration: InputDecoration(
                      labelText: 'Address Line 1',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: addressLine2Controller,
                    decoration: InputDecoration(
                      labelText: 'Address Line 2',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: postalCodeController,
                    decoration: InputDecoration(
                      labelText: 'Postal Code',
                      labelStyle: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontFamily: 'SF Pro Display',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              addressLine1Controller.text.isEmpty ||
                              addressLine2Controller.text.isEmpty ||
                              cityController.text.isEmpty ||
                              postalCodeController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('All fields must be filled.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          await _saveAddress();
                          Navigator.pop(context, {
                            'name': nameController.text,
                            'phoneNumber': phoneNumberController.text,
                            'addressLine1': addressLine1Controller.text,
                            'addressLine2': addressLine2Controller.text,
                            'city': cityController.text,
                            'postalCode': postalCodeController.text,
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: GlobalVariables.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: GlobalVariables.primaryColor,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
