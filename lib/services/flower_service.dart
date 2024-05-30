import 'package:dekora/models/flower_model.dart';

class FlowerService {
  // Hypothetical method to fetch flowers from a PostgreSQL database
  static Future<List<Flower>> fetchFlowers() async {
    // Example of what you might do if fetching from a PostgreSQL database
    /*
    final response = await http.get(Uri.parse('https://your-api-endpoint.com/flowers'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((flower) => Flower.fromJson(flower)).toList();
    } else {
      throw Exception('Failed to load flowers');
    }
    */

    // Mock data for now
    return [
      Flower(id: 1, name: 'Dahlia', imageUrl: 'assets/images/flower1.png'),
      Flower(id: 2, name: 'Roses', imageUrl: 'assets/images/flower2.png'),
      Flower(id: 3, name: 'Tulip', imageUrl: 'assets/images/flower3.png'),
      Flower(id: 4, name: 'Lily', imageUrl: 'assets/images/flower4.png'),
      Flower(id: 5, name: 'Sunflower', imageUrl: 'assets/images/flower5.png'),
      Flower(id: 6, name: 'Orchid', imageUrl: 'assets/images/flower6.png'),
      // Add more flowers here
    ];
  }
}
