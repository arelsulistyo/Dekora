import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  final String baseUrl = 'http://localhost:5000/takeCart/user/';

  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        final response = await http.get(Uri.parse('$baseUrl$userId'));

        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body);
          print(data.map((item) => item as Map<String, dynamic>).toList());
          return data.map((item) => item as Map<String, dynamic>).toList();
        } else {
          throw Exception('Failed to load cart items');
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      throw Exception('Error fetching cart items: $e');
    }
  }
}
