/// Product model representing a leather product in our ecommerce store
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final List<String>? additionalImages;
  final bool isAvailable;
  final Map<String, dynamic>? specifications;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.additionalImages,
    this.isAvailable = true,
    this.specifications,
  });

  /// Create a Product from map data
  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      additionalImages: data['additionalImages'] != null 
          ? List<String>.from(data['additionalImages']) 
          : null,
      isAvailable: data['isAvailable'] ?? true,
      specifications: data['specifications'],
    );
  }

  /// Convert Product to map data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'additionalImages': additionalImages,
      'isAvailable': isAvailable,
      'specifications': specifications,
    };
  }

  /// Create a copy of the product with updated fields
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
    List<String>? additionalImages,
    bool? isAvailable,
    Map<String, dynamic>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      additionalImages: additionalImages ?? this.additionalImages,
      isAvailable: isAvailable ?? this.isAvailable,
      specifications: specifications ?? this.specifications,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
