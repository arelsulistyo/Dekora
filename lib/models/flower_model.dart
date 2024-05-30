class Flower {
  final int id;
  final String name;
  final String imageUrl;

  Flower({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
