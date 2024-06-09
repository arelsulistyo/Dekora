import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekora/models/cart_item_model.dart';

class CartService {
  static const String _baseUrl = 'http://localhost:5000/cart';

  static Future<void> addItemToCart(String flowerId, int quantity) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final idToken = await user.getIdToken(true);

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'userId': user.uid,
        'flowerId': flowerId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add item to cart');
    }
  }

  static Future<void> updateCartItem(String flowerId, int quantity) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final idToken = await user.getIdToken(true);

    final response = await http.post(
      Uri.parse('$_baseUrl/${user.uid}/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'flowerId': flowerId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  static Future<List<CartItem>> fetchCartItems() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/${user.uid}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await user.getIdToken(true)}',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}
