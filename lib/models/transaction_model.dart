// transaction_model.dart
class Transaction {
  final String id;
  final String userId;
  final List<Item> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String shippingMethod;
  final bool productProtection;
  final DateTime date;

  Transaction({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.shippingMethod,
    required this.productProtection,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      userId: json['userId'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      totalAmount: json['totalAmount'].toDouble(),
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      shippingMethod: json['shippingMethod'],
      productProtection: json['productProtection'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Item {
  final String flowerId;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final int quantity;

  Item({
    required this.flowerId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      flowerId: json['flowerId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}
