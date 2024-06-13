import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/models/transaction_model.dart';

class TransactionService {
  static const String _baseUrl = 'http://localhost:5000/transactions';

  static Future<String?> createTransaction(
      Map<String, dynamic> transaction) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final idToken = await user.getIdToken(true);

    final response = await http.post(
      Uri.parse('$_baseUrl/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode(transaction),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final snapToken = responseData['snapToken'];
      if (snapToken != null && snapToken is String) {
        return snapToken;
      } else {
        // If snapToken is missing, return a default message or handle accordingly
        return null;
      }
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  static Future<List<Transaction>> getUserTransactions() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final idToken = await user.getIdToken(true);

    final response = await http.get(
      Uri.parse('$_baseUrl/${user.uid}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }
}
