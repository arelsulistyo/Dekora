import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/models/cart_item_model.dart';

class TransactionService {
  static const String _baseUrl = 'http://localhost:5000/transactions';

  static Future<void> createTransaction(
      List<CartItem> items, double totalPrice) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final transactionItems = items
        .map((item) => {
              'flowerId': item.flowerId,
              'quantity': item.quantity,
              'price': item.flower.price,
            })
        .toList();

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await user.getIdToken(true)}', // Ensure token refresh
      },
      body: json.encode({
        'userId': user.uid,
        'items': transactionItems,
        'totalPrice': totalPrice,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction');
    }
  }
}
