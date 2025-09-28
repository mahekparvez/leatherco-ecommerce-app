import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';

/// Main navigation bar widget matching Leatherology's exact design with mega menus
class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final TextEditingController _searchController = TextEditingController();
  String? _hoveredCategory;

  // Exact Leatherology navigation structure
  final Map<String, List<Map<String, dynamic>>> _megaMenuData = {
    'Women': [
      {'title': 'Handbags', 'items': ['View All', 'Crossbodies', 'Totes', 'Shoulder Bags', 'Mini Bags', 'Backpacks', 'Straps']},
      {'title': 'Wallets', 'items': ['View All', 'Women\'s Wallets', 'Card Holders', 'Checkbook Covers', 'Key & Coin']},
      {'title': 'Accessories', 'items': ['View All', 'Cosmetic Bags', 'Pouches', 'Jewelry Organizers']},
      {'title': 'Collections', 'items': ['Mia Collection', 'Greta Collection', 'Ciera Collection', 'Park Collection', 'Katy Collection', 'Kress Collection', 'Meadow Collection']},
      {'title': 'Special', 'items': ['View All', 'New Arrivals', 'Sport Collection', 'Sale']},
    ],
    'Men': [
      {'title': 'Wallets', 'items': ['View All', 'Bifold', 'Trifold', 'Card Holders', 'Money Clips', 'Checkbook Covers']},
      {'title': 'Bags', 'items': ['View All', 'Work Bags', 'Duffle Bags', 'Backpacks']},
      {'title': 'Toiletry & Accessories', 'items': ['View All', 'Watch & Valet', 'Key & Coin', 'Toiletry']},
      {'title': 'Special', 'items': ['View All', 'New Arrivals', 'Wallet Guide', 'Sport Collection', 'Sale']},
    ],
    'Home & Office': [
      {'title': 'Home', 'items': ['View All', 'Trays & Boxes', 'Home Decor', 'Tablescape']},
      {'title': 'Office', 'items': ['View All', 'Portfolios', 'Journals & Planners', 'Desk Accessories', 'Business Card Holders', 'Stationery & Refills']},
      {'title': 'Tech', 'items': ['View All', 'Laptop Sleeves', 'Laptop Bags', 'Phone Cases', 'Tablet Sleeves', 'Accessories']},
      {'title': 'Sport', 'items': ['View All', 'Tennis & Pickleball', 'Golf']},
      {'title': 'Special', 'items': ['View All', 'New Arrivals', 'Sale']},
    ],
    'Travel': [
      {'title': 'Travel Bags', 'items': ['View All', 'Duffle Bags', 'Backpacks', 'Laptop Bags']},
      {'title': 'Accessories', 'items': ['View All', 'Passport Holders', 'Travel Wallets', 'Luggage Tags', 'Travel Essentials']},
      {'title': 'Toiletry & Cosmetic', 'items': ['View All', 'Toiletry', 'Cosmetic Bags', 'Jewelry Organizers']},
      {'title': 'Special', 'items': ['View All', 'New Arrivals', 'Sport Collection', 'Sale']},
    ],
    'Gifts': [
      {'title': 'By Price', 'items': ['Under Rs. 500', 'Under Rs. 750', 'Under Rs. 1000']},
      {'title': 'By Occasion', 'items': ['Graduation', 'Wedding', 'Anniversary', 'Birthday']},
      {'title': 'Special', 'items': ['All Gifts', 'Gift Sets', 'Gift Cards', 'Sport Collection', 'New Arrivals']},
    ],
    'By Color': [
      {'title': 'Signature', 'items': ['Saddle Brown', 'Moss', 'Sand', 'Clementine', 'Celeste', 'Lime', 'Smoke', 'Deep Plum', 'Cocoa', 'Scarlet', 'Navy Blue', 'Camel', 'Cognac', 'Black Onyx', 'Black Pebble', 'Brown', 'Bordeaux']},
      {'title': 'Premium', 'items': ['Russet Suede', 'Juniper Suede', 'Forest Croc', 'Clementine/Sand Stripe', 'Frost', 'Cocoa Croc', 'Ecru', 'Mocha', 'Black Croc', 'Midnight Blue', 'Organic Canvas', 'Dove', 'Ivory', 'Black', 'Tan', 'Oxblood', 'Ebony', 'Espresso', 'Black Oil', 'Mahogany']},
    ],
    'Personalize': [
      {'title': 'Shop Personalization', 'items': ['Shop Trapunto', 'Shop Handpaint', 'Shop Script', 'Shop Logo']},
      {'title': 'Personalization Guides', 'items': ['Personalization Guide', 'Trapunto Guide', 'Hand Paint Guide', 'Deboss Guide', 'Logo Guide']},
    ],
    'Corporate': [
      {'title': 'Get Inspired', 'items': ['Find inspiration for your designs in our logo guide.']},
      {'title': 'About Our Program', 'items': ['Learn what makes our corporate gifting program unique and sign up for your corporate shopping account.']},
      {'title': 'Our Corporate Experience', 'items': ['Your complete overview of ordering, customization, and timelines for corporate gifting.']},
      {'title': 'Support', 'items': ['FAQs', 'Inquire Now']},
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingL,
        vertical: 16.0, // Exact Leatherology height
      ),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo - exact Leatherology styling
          GestureDetector(
            onTap: () => context.go('/'),
            child: const Text(
              'LEATHEROLOGY',
              style: TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingXL),
          
          // Mega Menu Categories - Fixed layout to prevent overflow
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _megaMenuData.keys.map((category) {
                  return _buildMegaMenuCategory(category);
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingL),
          
          // Search Bar - exact Leatherology styling
          Container(
            width: 200, // Reduced width to prevent overflow
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(0), // No border radius like Leatherology
              border: Border.all(color: AppTheme.borderColor, width: 1),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.textLight,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppTheme.textLight,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AppTheme.textPrimary,
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.go('/shop?search=$query');
                }
              },
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // Cart Icon with Badge - exact Leatherology styling
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () => context.go('/cart'),
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 24,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: AppTheme.errorColor,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartProvider.itemCount}',
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                            color: AppTheme.backgroundColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          
          const SizedBox(width: AppTheme.spacingS),
          
          // Account/Login - exact Leatherology styling
          TextButton(
            onPressed: () {
              // TODO: Implement login/account functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login functionality coming soon!'),
                ),
              );
            },
            child: const Text(
              'ACCOUNT',
              style: TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMegaMenuCategory(String category) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCategory = category),
      onExit: (_) => setState(() => _hoveredCategory = null),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingS,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.go('/shop?category=${Uri.encodeComponent(category)}'),
              child: Text(
                category,
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            // Mega menu dropdown
            if (_hoveredCategory == category)
              _buildMegaMenuDropdown(category),
          ],
        ),
      ),
    );
  }

  Widget _buildMegaMenuDropdown(String category) {
    final menuData = _megaMenuData[category]!;
    
    return Positioned(
      top: 40,
      left: 0,
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(AppTheme.spacingL),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menuData.map((section) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section['title'],
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  ...section['items'].map<Widget>((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: TextButton(
                        onPressed: () {
                          context.go('/shop?category=${Uri.encodeComponent(category)}&subcategory=${Uri.encodeComponent(item)}');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
