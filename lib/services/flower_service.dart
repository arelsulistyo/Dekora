import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dekora/models/flower_model.dart';

class FlowerService {
  static const String _baseUrl = 'http://localhost:5000';

  static Future<List<Flower>> fetchFlowers() async {
    final response = await http.get(Uri.parse('$_baseUrl/flowers'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((flower) => Flower.fromJson(flower)).toList();
    } else {
      throw Exception('Failed to load flowers');
    }
  }
}
