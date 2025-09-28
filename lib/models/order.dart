class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final double shippingCost;
  final double taxAmount;
  final String status;
  final DateTime orderDate;
  final DateTime? shippedDate;
  final DateTime? deliveredDate;
  final ShippingAddress shippingAddress;
  final String paymentMethod;
  final String trackingNumber;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxAmount,
    required this.status,
    required this.orderDate,
    this.shippedDate,
    this.deliveredDate,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.trackingNumber,
  });

  double get grandTotal => totalAmount + shippingCost + taxAmount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxAmount': taxAmount,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'shippedDate': shippedDate?.toIso8601String(),
      'deliveredDate': deliveredDate?.toIso8601String(),
      'shippingAddress': shippingAddress.toJson(),
      'paymentMethod': paymentMethod,
      'trackingNumber': trackingNumber,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      shippingCost: json['shippingCost'].toDouble(),
      taxAmount: json['taxAmount'].toDouble(),
      status: json['status'],
      orderDate: DateTime.parse(json['orderDate']),
      shippedDate: json['shippedDate'] != null 
          ? DateTime.parse(json['shippedDate']) 
          : null,
      deliveredDate: json['deliveredDate'] != null 
          ? DateTime.parse(json['deliveredDate']) 
          : null,
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      paymentMethod: json['paymentMethod'],
      trackingNumber: json['trackingNumber'],
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String size;
  final String color;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
  });

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      size: json['size'],
      color: json['color'],
    );
  }
}

class ShippingAddress {
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String phone;

  ShippingAddress({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.phone,
  });

  String get fullName => '$firstName $lastName';
  String get fullAddress => '$address, $city, $state $zipCode, $country';

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'phone': phone,
    };
  }

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      country: json['country'],
      phone: json['phone'],
    );
  }
}