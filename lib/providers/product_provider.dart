import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// ProductProvider manages product data and search functionality
/// Uses ChangeNotifier to notify UI when product data changes
class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  /// Get all products
  List<Product> get products => List.unmodifiable(_products);

  /// Get filtered products based on category and search
  List<Product> get filteredProducts => List.unmodifiable(_filteredProducts);

  /// Get selected category
  String get selectedCategory => _selectedCategory;

  /// Get search query
  String get searchQuery => _searchQuery;

  /// Check if data is loading
  bool get isLoading => _isLoading;

  /// Get all available categories
  List<String> get categories {
    final categorySet = <String>{'All'};
    for (final product in _products) {
      categorySet.add(product.category);
    }
    return categorySet.toList()..sort();
  }

  /// Load products from Firebase
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would use FirebaseService.getProducts()
      // For now, we'll use sample data
      _products = _getSampleProducts();
      _applyFilters();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  /// Search products by query
  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Apply both category and search filters
  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesCategory = _selectedCategory == 'All' || 
                             product.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
                           product.name.toLowerCase().contains(_searchQuery) ||
                           product.description.toLowerCase().contains(_searchQuery);
      
      return matchesCategory && matchesSearch;
    }).toList();
    
    notifyListeners();
  }

  /// Get a product by ID
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get featured products (first 6 products)
  List<Product> get featuredProducts {
    return _products.take(6).toList();
  }

  /// Get products by category
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  /// Sample products data (replace with Firebase data in production)
  List<Product> _getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Classic Leather Wallet',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Handcrafted from premium Italian leather with a timeless design. Features multiple card slots and a coin pocket.',
        category: 'Wallets',
        isAvailable: true,
        specifications: {
          'material': 'Italian Leather',
          'dimensions': '4.5" x 3.5"',
          'color': 'Brown'
        },
      ),
      Product(
        id: '2',
        name: 'Executive Briefcase',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Professional briefcase perfect for business meetings. Made from full grain leather with brass hardware.',
        category: 'Men',
        isAvailable: true,
        specifications: {
          'material': 'Full Grain Leather',
          'dimensions': '16" x 12" x 4"',
          'color': 'Black'
        },
      ),
      Product(
        id: '3',
        name: 'Designer Handbag',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Elegant handbag with modern design and premium materials. Perfect for everyday use.',
        category: 'Women',
        isAvailable: true,
        specifications: {
          'material': 'Soft Leather',
          'dimensions': '12" x 8" x 6"',
          'color': 'Tan'
        },
      ),
      Product(
        id: '4',
        name: 'Classic Leather Belt',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Durable leather belt with adjustable sizing. Made from genuine leather with a classic buckle.',
        category: 'Belts',
        isAvailable: true,
        specifications: {
          'material': 'Genuine Leather',
          'width': '1.5"',
          'color': 'Brown'
        },
      ),
      Product(
        id: '5',
        name: 'Premium Leather Jacket',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Stylish leather jacket with a modern fit. Made from high-quality leather with attention to detail.',
        category: 'Men',
        isAvailable: true,
        specifications: {
          'material': 'Premium Leather',
          'sizes': 'S, M, L, XL',
          'color': 'Black'
        },
      ),
      Product(
        id: '6',
        name: 'Elegant Clutch',
        price: 700.00,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
        description: 'Sophisticated clutch bag perfect for evening events. Features a magnetic closure and interior pockets.',
        category: 'Women',
        isAvailable: true,
        specifications: {
          'material': 'Soft Leather',
          'dimensions': '10" x 6" x 2"',
          'color': 'Black'
        },
      ),
    ];
  }
}
