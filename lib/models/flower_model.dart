// flower_model.dart
class Flower {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String type;
  final String size;
  final String description;  // Add description field

  Flower({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.type,
    required this.size,
    required this.description,
  });

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      type: json['type'],
      size: json['size'],
      description: json['description'],  // Parse description
    );
  }
}
