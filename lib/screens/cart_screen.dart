import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sticky_header.dart';
import '../widgets/footer.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../utils/app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // Sticky header with announcement bar and navigation
              const StickyHeader(),
              
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Cart content
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Shopping Cart',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingL),
                            
                            Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                if (cartProvider.items.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: AppTheme.spacingXXXL),
                                        Icon(
                                          Icons.shopping_bag_outlined,
                                          size: 64,
                                          color: AppTheme.textLight,
                                        ),
                                        SizedBox(height: AppTheme.spacingL),
                                        Text(
                                          'Your cart is empty',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                        SizedBox(height: AppTheme.spacingM),
                                        Text(
                                          'Add some products to get started',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.textLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                
                                return Column(
                                  children: [
                                    // Cart items
                                    ...cartProvider.items.map((item) => _buildCartItem(item, cartProvider)),
                                    
                                    const SizedBox(height: AppTheme.spacingXL),
                                    
                                    // Cart summary
                                    Container(
                                      padding: const EdgeInsets.all(AppTheme.spacingL),
                                      decoration: BoxDecoration(
                                        color: AppTheme.surfaceColor,
                                        border: Border.all(color: AppTheme.borderColor),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                              Text(
                                                '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppTheme.spacingS),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Shipping',
                                                style: TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                              Text(
                                                cartProvider.totalPrice >= 2500 ? 'FREE' : 'Rs. 100',
                                                style: const TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Total',
                                                style: TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                              Text(
                                                'Rs. ${(cartProvider.totalPrice + (cartProvider.totalPrice >= 2500 ? 0 : 100)).toStringAsFixed(0)}',
                                                style: const TextStyle(
                                                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.textPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppTheme.spacingL),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () => context.go('/checkout'),
                                              child: const Text('Proceed to Checkout'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      // Footer
                      const CustomFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Icon(
              Icons.image,
              color: AppTheme.textLight,
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Quantity controls
          Row(
            children: [
              IconButton(
                onPressed: () => cartProvider.updateQuantity(item.product.id, item.quantity - 1),
                icon: const Icon(Icons.remove, size: 20),
              ),
              Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () => cartProvider.updateQuantity(item.product.id, item.quantity + 1),
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // Remove button
          IconButton(
            onPressed: () => cartProvider.removeItem(item.product.id),
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
          ),
        ],
      ),
    );
  }
}
