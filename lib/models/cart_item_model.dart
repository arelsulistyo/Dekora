import 'flower_model.dart';

class CartItem {
  final String id;
  final String userId;
  final String flowerId;
  final int quantity;
  final Flower flower;

  CartItem({
    required this.id,
    required this.userId,
    required this.flowerId,
    required this.quantity,
    required this.flower,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      userId: json['userId'],
      flowerId: json['flowerId']['_id'],
      quantity: json['quantity'],
      flower: Flower.fromJson(json['flowerId']),
    );
  }
}
