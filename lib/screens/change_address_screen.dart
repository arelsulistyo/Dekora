import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/global_variables.dart';
import 'edit_address_screen.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  String addressLine1 = "";
  String addressLine2 = "";
  String city = "";
  String postalCode = "";
  String name = "";
  String phoneNumber = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddressDetails();
  }

  Future<void> _loadAddressDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          name = doc['name'] ?? '';
          phoneNumber = doc['phoneNumber'] ?? '';
          addressLine1 = doc['addressLine1'] ?? '';
          addressLine2 = doc['addressLine2'] ?? '';
          city = doc['city'] ?? '';
          postalCode = doc['postalCode'] ?? '';
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateAddressDetails(Map<String, String> newDetails) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(newDetails);
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
          'Change Address',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontFamily: 'Laviossa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                            color: GlobalVariables.primaryColor,
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
                                name.isNotEmpty ? name : 'Name not set',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                phoneNumber.isNotEmpty
                                    ? phoneNumber
                                    : 'Phone number not set',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                (addressLine1.isNotEmpty ||
                                        addressLine2.isNotEmpty ||
                                        city.isNotEmpty ||
                                        postalCode.isNotEmpty)
                                    ? '$addressLine1, $addressLine2, $city, $postalCode'
                                    : 'Address not set',
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
                                          addressLine1: addressLine1,
                                          addressLine2: addressLine2,
                                          city: city,
                                          postalCode: postalCode,
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        name = result['name'];
                                        phoneNumber = result['phoneNumber'];
                                        addressLine1 = result['addressLine1'];
                                        addressLine2 = result['addressLine2'];
                                        city = result['city'];
                                        postalCode = result['postalCode'];
                                      });
                                      await _updateAddressDetails({
                                        'name': name,
                                        'phoneNumber': phoneNumber,
                                        'addressLine1': addressLine1,
                                        'addressLine2': addressLine2,
                                        'city': city,
                                        'postalCode': postalCode,
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
