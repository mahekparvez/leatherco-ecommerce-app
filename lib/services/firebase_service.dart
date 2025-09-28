import '../models/order.dart';

/// Mock Firebase service for demo purposes
/// In production, replace with actual Firebase implementation
class FirebaseService {
  /// Save a new order (mock implementation)
  static Future<String?> saveOrder(Order order) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Generate a mock order ID
      final orderId = 'ORDER_${DateTime.now().millisecondsSinceEpoch}';
      
      print('Order saved with ID: $orderId');
      return orderId;
    } catch (e) {
      print('Error saving order: $e');
      return null;
    }
  }
}
