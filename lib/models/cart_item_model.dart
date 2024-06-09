class CartItem {
  final String id;
  final String flowerId;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  int quantity;
  bool selected;

  CartItem({
    required this.id,
    required this.flowerId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,
    this.selected = true,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      flowerId: json['flowerId']['_id'],
      name: json['flowerId']['name'],
      imageUrl: json['flowerId']['imageUrl'],
      description: "${json['flowerId']['type']} | ${json['flowerId']['size']}",
      price: json['flowerId']['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'flowerId': flowerId,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'quantity': quantity,
      'selected': selected,
    };
  }
}
