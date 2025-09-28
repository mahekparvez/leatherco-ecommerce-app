import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

/// Google Sheets service for managing orders database
class GoogleSheetsService {
  // Replace with your actual Google Sheets API credentials
  static const String _apiKey = 'YOUR_GOOGLE_SHEETS_API_KEY';
  static const String _spreadsheetId = 'YOUR_SPREADSHEET_ID';
  static const String _ordersSheetName = 'Orders';
  static const String _baseUrl = 'https://sheets.googleapis.com/v4/spreadsheets';

  /// Save order to Google Sheets
  static Future<bool> saveOrder(Order order) async {
    try {
      final url = '$_baseUrl/$_spreadsheetId/values/$_ordersSheetName:append?valueInputOption=USER_ENTERED&key=$_apiKey';
      
      // Prepare order data for Google Sheets
      final orderData = _formatOrderForSheets(order);
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'values': [orderData]
        }),
      );

      if (response.statusCode == 200) {
        print('Order saved to Google Sheets successfully');
        return true;
      } else {
        print('Failed to save order to Google Sheets: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error saving order to Google Sheets: $e');
      return false;
    }
  }

  /// Get all orders from Google Sheets
  static Future<List<Order>> getAllOrders() async {
    try {
      final url = '$_baseUrl/$_spreadsheetId/values/$_ordersSheetName?key=$_apiKey';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final values = data['values'] as List<dynamic>?;
        
        if (values != null && values.length > 1) {
          // Skip header row
          final orders = values.skip(1).map((row) => _parseOrderFromSheets(row)).toList();
          return orders;
        }
      }
      
      return [];
    } catch (e) {
      print('Error fetching orders from Google Sheets: $e');
      return [];
    }
  }

  /// Update order status in Google Sheets
  static Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      // First, find the row with the order ID
      final orders = await getAllOrders();
      final orderIndex = orders.indexWhere((order) => order.id == orderId);
      
      if (orderIndex == -1) {
        print('Order not found: $orderId');
        return false;
      }
      
      // Update the status in the sheet (row index + 2 because of header and 1-based indexing)
      final rowIndex = orderIndex + 2;
      final url = '$_baseUrl/$_spreadsheetId/values/$_ordersSheetName!H$rowIndex?valueInputOption=USER_ENTERED&key=$_apiKey';
      
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'values': [[newStatus]]
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating order status: $e');
      return false;
    }
  }

  /// Format order data for Google Sheets
  static List<String> _formatOrderForSheets(Order order) {
    return [
      order.id,
      order.userId,
      order.orderDate.toIso8601String(),
      order.status,
      order.shippingAddress.fullName,
      order.shippingAddress.phone,
      order.shippingAddress.fullAddress,
      order.paymentMethod,
      order.trackingNumber,
      order.totalAmount.toString(),
      order.shippingCost.toString(),
      order.taxAmount.toString(),
      order.grandTotal.toString(),
      order.items.length.toString(),
      _formatOrderItems(order.items),
    ];
  }

  /// Format order items for Google Sheets
  static String _formatOrderItems(List<OrderItem> items) {
    return items.map((item) => 
      '${item.productName} (${item.quantity}x) - Rs.${item.subtotal.toStringAsFixed(0)}'
    ).join('; ');
  }

  /// Parse order from Google Sheets row
  static Order _parseOrderFromSheets(List<dynamic> row) {
    try {
      return Order(
        id: row[0]?.toString() ?? '',
        userId: row[1]?.toString() ?? '',
        items: _parseOrderItems(row[15]?.toString() ?? ''),
        totalAmount: double.tryParse(row[9]?.toString() ?? '0') ?? 0.0,
        shippingCost: double.tryParse(row[10]?.toString() ?? '0') ?? 0.0,
        taxAmount: double.tryParse(row[11]?.toString() ?? '0') ?? 0.0,
        status: row[3]?.toString() ?? 'Unknown',
        orderDate: DateTime.tryParse(row[2]?.toString() ?? '') ?? DateTime.now(),
        shippedDate: null, // Not stored in current format
        deliveredDate: null, // Not stored in current format
        shippingAddress: ShippingAddress(
          firstName: (row[4]?.toString() ?? '').split(' ').first,
          lastName: (row[4]?.toString() ?? '').split(' ').length > 1 
              ? (row[4]?.toString() ?? '').split(' ').skip(1).join(' ') 
              : '',
          address: row[6]?.toString() ?? '',
          city: 'Mumbai', // Default
          state: 'Maharashtra', // Default
          zipCode: '400001', // Default
          country: 'India',
          phone: row[5]?.toString() ?? '',
        ),
        paymentMethod: row[7]?.toString() ?? 'Unknown',
        trackingNumber: row[8]?.toString() ?? '',
      );
    } catch (e) {
      print('Error parsing order from sheets: $e');
      // Return a default order
      return Order(
        id: row[0]?.toString() ?? '',
        userId: row[1]?.toString() ?? '',
        items: [],
        totalAmount: 0.0,
        shippingCost: 0.0,
        taxAmount: 0.0,
        status: 'Unknown',
        orderDate: DateTime.now(),
        shippingAddress: ShippingAddress(
          firstName: 'Unknown',
          lastName: 'User',
          address: 'Unknown',
          city: 'Mumbai',
          state: 'Maharashtra',
          zipCode: '400001',
          country: 'India',
          phone: 'Unknown',
        ),
        paymentMethod: 'Unknown',
        trackingNumber: '',
      );
    }
  }

  /// Parse order items from string
  static List<OrderItem> _parseOrderItems(String itemsString) {
    if (itemsString.isEmpty) return [];
    
    try {
      final itemStrings = itemsString.split(';');
      return itemStrings.map((itemString) {
        final parts = itemString.trim().split(' - Rs.');
        final namePart = parts[0];
        final pricePart = parts.length > 1 ? parts[1] : '0';
        
        // Extract quantity from name (e.g., "Product Name (2x)")
        final quantityMatch = RegExp(r'\((\d+)x\)').firstMatch(namePart);
        final quantity = quantityMatch != null ? int.parse(quantityMatch.group(1)!) : 1;
        final productName = namePart.replaceAll(RegExp(r'\(\d+x\)'), '').trim();
        
        return OrderItem(
          productId: 'unknown',
          productName: productName,
          productImage: '',
          price: double.tryParse(pricePart) ?? 0.0,
          quantity: quantity,
          size: 'One Size',
          color: 'Default',
        );
      }).toList();
    } catch (e) {
      print('Error parsing order items: $e');
      return [];
    }
  }

  /// Create Google Sheets template
  static Future<bool> createTemplate() async {
    try {
      final url = '$_baseUrl/$_spreadsheetId/values/$_ordersSheetName!A1:O1?valueInputOption=USER_ENTERED&key=$_apiKey';
      
      final headers = [
        'Order ID',
        'User ID', 
        'Order Date',
        'Status',
        'Customer Name',
        'Phone',
        'Address',
        'Payment Method',
        'Tracking Number',
        'Subtotal',
        'Shipping Cost',
        'Tax Amount',
        'Total Amount',
        'Item Count',
        'Items'
      ];
      
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'values': [headers]
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error creating template: $e');
      return false;
    }
  }
}
