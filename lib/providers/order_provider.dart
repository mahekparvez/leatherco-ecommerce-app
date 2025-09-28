import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../services/google_sheets_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  // Get orders for a specific user
  List<Order> getOrdersForUser(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }

  // Get order by ID
  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  // Load orders from Google Sheets
  Future<void> loadOrdersFromSheets(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Try to load from Google Sheets first
      final sheetsOrders = await GoogleSheetsService.getAllOrders();
      if (sheetsOrders.isNotEmpty) {
        _orders = sheetsOrders.where((order) => order.userId == userId).toList();
      } else {
        // Fallback to sample data if no Google Sheets data
        await _loadSampleOrders(userId);
      }
    } catch (e) {
      print('Error loading orders from Google Sheets: $e');
      // Fallback to sample data
      await _loadSampleOrders(userId);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load sample orders for demo (fallback)
  Future<void> _loadSampleOrders(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _orders = [
      Order(
        id: 'ORDER_001',
        userId: userId,
        items: [
          OrderItem(
            productId: '1',
            productName: 'Classic Leather Wallet',
            productImage: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
            price: 700.00,
            quantity: 1,
            size: 'One Size',
            color: 'Brown',
          ),
          OrderItem(
            productId: '2',
            productName: 'Premium Leather Bag',
            productImage: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
            price: 700.00,
            quantity: 1,
            size: 'Medium',
            color: 'Black',
          ),
        ],
        totalAmount: 1400.00,
        shippingCost: 0.00,
        taxAmount: 0.00,
        status: 'Delivered',
        orderDate: DateTime.now().subtract(const Duration(days: 15)),
        shippedDate: DateTime.now().subtract(const Duration(days: 12)),
        deliveredDate: DateTime.now().subtract(const Duration(days: 8)),
        shippingAddress: ShippingAddress(
          firstName: 'John',
          lastName: 'Doe',
          address: '123 Main Street',
          city: 'Mumbai',
          state: 'Maharashtra',
          zipCode: '400001',
          country: 'India',
          phone: '+91 9876543210',
        ),
        paymentMethod: 'Credit Card',
        trackingNumber: 'TRK123456789',
      ),
      Order(
        id: 'ORDER_002',
        userId: userId,
        items: [
          OrderItem(
            productId: '3',
            productName: 'Leather Belt',
            productImage: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
            price: 700.00,
            quantity: 2,
            size: 'L',
            color: 'Brown',
          ),
        ],
        totalAmount: 1400.00,
        shippingCost: 0.00,
        taxAmount: 0.00,
        status: 'Shipped',
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        shippedDate: DateTime.now().subtract(const Duration(days: 2)),
        shippingAddress: ShippingAddress(
          firstName: 'John',
          lastName: 'Doe',
          address: '123 Main Street',
          city: 'Mumbai',
          state: 'Maharashtra',
          zipCode: '400001',
          country: 'India',
          phone: '+91 9876543210',
        ),
        paymentMethod: 'UPI',
        trackingNumber: 'TRK987654321',
      ),
      Order(
        id: 'ORDER_003',
        userId: userId,
        items: [
          OrderItem(
            productId: '4',
            productName: 'Leather Watch Strap',
            productImage: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
            price: 700.00,
            quantity: 1,
            size: '20mm',
            color: 'Black',
          ),
        ],
        totalAmount: 700.00,
        shippingCost: 0.00,
        taxAmount: 0.00,
        status: 'Processing',
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        shippingAddress: ShippingAddress(
          firstName: 'John',
          lastName: 'Doe',
          address: '123 Main Street',
          city: 'Mumbai',
          state: 'Maharashtra',
          zipCode: '400001',
          country: 'India',
          phone: '+91 9876543210',
        ),
        paymentMethod: 'Net Banking',
        trackingNumber: '',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  // Add a new order
  Future<void> addOrder(Order order) async {
    _orders.add(order);
    notifyListeners();
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _orders[orderIndex];
      final updatedOrder = Order(
        id: order.id,
        userId: order.userId,
        items: order.items,
        totalAmount: order.totalAmount,
        shippingCost: order.shippingCost,
        taxAmount: order.taxAmount,
        status: newStatus,
        orderDate: order.orderDate,
        shippedDate: newStatus == 'Shipped' || newStatus == 'Delivered' 
            ? order.shippedDate ?? DateTime.now() 
            : order.shippedDate,
        deliveredDate: newStatus == 'Delivered' 
            ? DateTime.now() 
            : order.deliveredDate,
        shippingAddress: order.shippingAddress,
        paymentMethod: order.paymentMethod,
        trackingNumber: order.trackingNumber,
      );
      _orders[orderIndex] = updatedOrder;
      
      // Update in Google Sheets
      try {
        await GoogleSheetsService.updateOrderStatus(orderId, newStatus);
      } catch (e) {
        print('Error updating order status in Google Sheets: $e');
      }
      
      notifyListeners();
    }
  }

  // Get orders by status
  List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Get recent orders (last 30 days)
  List<Order> getRecentOrders(String userId) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return _orders
        .where((order) => 
            order.userId == userId && 
            order.orderDate.isAfter(thirtyDaysAgo))
        .toList();
  }
}
