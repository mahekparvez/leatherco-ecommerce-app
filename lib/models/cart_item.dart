import 'product.dart';

/// CartItem model representing an item in the shopping cart
/// Contains a product and its quantity
class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  /// Calculate the total price for this cart item
  double get totalPrice => product.price * quantity;

  /// Create a copy with updated quantity
  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Create CartItem from map data
  static CartItem fromMap(Map<String, dynamic> data) {
    return CartItem(
      product: Product.fromMap(data['product'], data['productId']),
      quantity: data['quantity'] ?? 1,
    );
  }

  /// Convert CartItem to map data
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'productId': product.id,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && 
           other.product.id == product.id && 
           other.quantity == quantity;
  }

  @override
  int get hashCode => product.id.hashCode ^ quantity.hashCode;
}
