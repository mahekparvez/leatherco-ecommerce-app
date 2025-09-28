import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import "../widgets/sticky_header.dart";
import '../widgets/footer.dart';
import '../providers/cart_provider.dart';
import '../services/firebase_service.dart';
import '../services/google_sheets_service.dart';
import '../models/order.dart';
import '../utils/app_theme.dart';

/// Checkout screen for processing orders
/// Contains customer information form and order summary
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isProcessing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Announcement bar
          const StickyHeader(
          ),
          
          // Navigation bar
          
          
          // Main content
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                if (cartProvider.isEmpty) {
                  return _buildEmptyCart();
                }
                
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Checkout header
                      _buildCheckoutHeader(),
                      
                      // Checkout form
                      _buildCheckoutForm(cartProvider),
                      
                      // Footer
                      const CustomFooter(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty cart state
  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppTheme.textLight,
            ),
            const SizedBox(height: AppTheme.spacingL),
            Text(
              'Your cart is empty',
              style: AppTheme.heading3.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              'Add some products to proceed to checkout',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textLight,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            ElevatedButton(
              onPressed: () => context.go('/shop'),
              child: const Text('CONTINUE SHOPPING'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build checkout header
  Widget _buildCheckoutHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
        vertical: AppTheme.spacingXL,
      ),
      child: Row(
        children: [
          Text(
            'CHECKOUT',
            style: AppTheme.heading1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Build checkout form
  Widget _buildCheckoutForm(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer information form
          Expanded(
            flex: 2,
            child: _buildCustomerForm(),
          ),
          
          const SizedBox(width: AppTheme.spacingXXL),
          
          // Order summary
          Expanded(
            flex: 1,
            child: _buildOrderSummary(cartProvider),
          ),
        ],
      ),
    );
  }

  /// Build customer information form
  Widget _buildCustomerForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CUSTOMER INFORMATION',
                style: AppTheme.heading4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),
              
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Address field
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Shipping Address',
                  hintText: 'Enter your complete shipping address',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your shipping address';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Notes field (optional)
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Order Notes (Optional)',
                  hintText: 'Any special instructions for your order',
                ),
                maxLines: 2,
              ),
              
              const SizedBox(height: AppTheme.spacingXL),
              
              // Place order button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : () => _placeOrder(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingL,
                    ),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(
                          color: AppTheme.backgroundColor,
                        )
                      : const Text('PLACE ORDER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build order summary
  Widget _buildOrderSummary(CartProvider cartProvider) {
    final shippingCost = cartProvider.totalPrice >= 2500 ? 0.0 : 100.0;
    final totalAmount = cartProvider.totalPrice + shippingCost;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ORDER SUMMARY',
              style: AppTheme.heading4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            
            // Order items
            ...cartProvider.items.map((cartItem) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.product.name,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Qty: ${cartItem.quantity}',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'USD ${cartItem.totalPrice.toStringAsFixed(2)}',
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            const Divider(),
            
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: AppTheme.bodyMedium,
                ),
                Text(
                  'USD ${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacingS),
            
            // Shipping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping',
                  style: AppTheme.bodyMedium,
                ),
                Text(
                  shippingCost == 0 ? 'FREE' : 'USD ${shippingCost.toStringAsFixed(2)}',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: shippingCost == 0 ? AppTheme.secondaryColor : AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            
            const Divider(),
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'USD ${totalAmount.toStringAsFixed(2)}',
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Place order
  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final cartProvider = context.read<CartProvider>();
      
      // Create order
      final order = Order(
        id: 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}', // Temporary user ID
        items: cartProvider.items.map((cartItem) => OrderItem(
          productId: cartItem.product.id,
          productName: cartItem.product.name,
          productImage: cartItem.product.imageUrl,
          price: cartItem.product.price,
          quantity: cartItem.quantity,
          size: 'One Size', // Default size
          color: 'Default', // Default color
        )).toList(),
        totalAmount: cartProvider.totalPrice,
        shippingCost: cartProvider.totalPrice >= 2500 ? 0 : 100,
        taxAmount: 0,
        status: 'Processing',
        orderDate: DateTime.now(),
        shippingAddress: ShippingAddress(
          firstName: _nameController.text.split(' ').first,
          lastName: _nameController.text.split(' ').length > 1 
              ? _nameController.text.split(' ').skip(1).join(' ') 
              : '',
          address: _addressController.text,
          city: 'Mumbai', // Default city
          state: 'Maharashtra', // Default state
          zipCode: '400001', // Default zip
          country: 'India',
          phone: '+91 9876543210', // Default phone
        ),
        paymentMethod: 'Credit Card', // Default payment method
        trackingNumber: '',
      );

      // Save order to Google Sheets
      final sheetsSuccess = await GoogleSheetsService.saveOrder(order);
      
      // Also save to Firebase (if available)
      final orderId = await FirebaseService.saveOrder(order);
      
      if (sheetsSuccess || orderId != null) {
        // Clear cart
        cartProvider.clearCart();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order placed successfully! Order ID: $orderId'),
            duration: const Duration(seconds: 5),
          ),
        );
        
        // Navigate to home
        context.go('/');
      } else {
        throw Exception('Failed to save order');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error placing order: $e'),
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}
