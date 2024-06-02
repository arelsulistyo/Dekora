class Flower {
  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final String size;
  final double price;
  final String description;
  final int stock; // Add stock field

  Flower({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.size,
    required this.price,
    required this.description,
    required this.stock, // Initialize stock field
  });

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      type: json['type'],
      size: json['size'],
      price: json['price'].toDouble(),
      description: json['description'],
      stock: json['stock'], // Parse stock field
    );
  }
}
