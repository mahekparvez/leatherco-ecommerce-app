import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';

class MegaMenu extends StatefulWidget {
  final String category;
  final VoidCallback onClose;

  const MegaMenu({
    super.key,
    required this.category,
    required this.onClose,
  });

  @override
  State<MegaMenu> createState() => _MegaMenuState();
}

class _MegaMenuState extends State<MegaMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Mega menu data matching Leatherco's structure
  final Map<String, Map<String, dynamic>> _megaMenuData = {
    'Women': {
      'columns': [
        {
          'title': 'Shop All',
          'items': [
            {'name': 'Handbags', 'subitems': ['Crossbodies', 'Totes', 'Shoulder Bags', 'Mini Bags']},
            {'name': 'Wallets', 'subitems': ['Women\'s Wallets', 'Card Holders', 'Checkbook Covers']},
            {'name': 'Small Leather Goods', 'subitems': ['Cosmetic Bags', 'Pouches', 'Jewelry Organizers']},
            {'name': 'Belts', 'subitems': ['Classic Belts', 'Chain Belts', 'Wide Belts']},
          ]
        },
        {
          'title': 'Featured Collections',
          'items': [
            {'name': 'New Arrivals', 'subitems': []},
            {'name': 'Best Sellers', 'subitems': []},
            {'name': 'Seasonal Colors', 'subitems': []},
          ]
        },
        {
          'title': 'Shop Women',
          'isPromo': true,
          'image': 'assets/images/women-promo.jpg',
          'cta': 'Shop Women',
        }
      ]
    },
    'Men': {
      'columns': [
        {
          'title': 'Shop All',
          'items': [
            {'name': 'Wallets', 'subitems': ['Bifold', 'Trifold', 'Card Holders', 'Money Clips']},
            {'name': 'Bags', 'subitems': ['Work Bags', 'Duffle Bags', 'Backpacks']},
            {'name': 'Toiletry & Accessories', 'subitems': ['Watch & Valet', 'Key & Coin', 'Toiletry']},
          ]
        },
        {
          'title': 'Featured Collections',
          'items': [
            {'name': 'New Arrivals', 'subitems': []},
            {'name': 'Wallet Guide', 'subitems': []},
            {'name': 'Sport Collection', 'subitems': []},
          ]
        },
        {
          'title': 'Shop Men',
          'isPromo': true,
          'image': 'assets/images/men-promo.jpg',
          'cta': 'Shop Men',
        }
      ]
    },
    'Home & Office': {
      'columns': [
        {
          'title': 'Desk',
          'items': [
            {'name': 'Portfolios', 'subitems': []},
            {'name': 'Padfolios', 'subitems': []},
            {'name': 'Desk Pads', 'subitems': []},
          ]
        },
        {
          'title': 'Tech',
          'items': [
            {'name': 'Laptop Sleeves', 'subitems': []},
            {'name': 'iPad Covers', 'subitems': []},
          ]
        },
        {
          'title': 'Organization',
          'items': [
            {'name': 'Keychains', 'subitems': []},
            {'name': 'Cases', 'subitems': []},
            {'name': 'Accessories', 'subitems': []},
          ]
        },
        {
          'title': 'Shop Home & Office',
          'isPromo': true,
          'image': 'assets/images/home-office-promo.jpg',
          'cta': 'Shop Home & Office',
        }
      ]
    },
    'Sport': {
      'columns': [
        {
          'title': 'Fitness Accessories',
          'items': [
            {'name': 'Gym Bags', 'subitems': []},
            {'name': 'Duffles', 'subitems': []},
            {'name': 'Water Bottle Cases', 'subitems': []},
          ]
        },
        {
          'title': 'Outdoors',
          'items': [
            {'name': 'Picnic Sets', 'subitems': []},
            {'name': 'Travel Blankets', 'subitems': []},
          ]
        },
        {
          'title': 'Featured',
          'isPromo': true,
          'image': 'assets/images/sport-promo.jpg',
          'cta': 'Shop Sport',
        }
      ]
    },
    'Travel': {
      'columns': [
        {
          'title': 'Luggage',
          'items': [
            {'name': 'Carry-ons', 'subitems': []},
            {'name': 'Duffels', 'subitems': []},
            {'name': 'Weekenders', 'subitems': []},
          ]
        },
        {
          'title': 'Accessories',
          'items': [
            {'name': 'Passport Holders', 'subitems': []},
            {'name': 'Luggage Tags', 'subitems': []},
            {'name': 'Toiletry Kits', 'subitems': []},
          ]
        },
        {
          'title': 'Travel Essentials',
          'isPromo': true,
          'image': 'assets/images/travel-promo.jpg',
          'cta': 'Shop Travel',
        }
      ]
    },
    'Gifts': {
      'columns': [
        {
          'title': 'By Occasion',
          'items': [
            {'name': 'Wedding', 'subitems': []},
            {'name': 'Graduation', 'subitems': []},
            {'name': 'Corporate', 'subitems': []},
          ]
        },
        {
          'title': 'By Recipient',
          'items': [
            {'name': 'For Him', 'subitems': []},
            {'name': 'For Her', 'subitems': []},
            {'name': 'For Everyone', 'subitems': []},
          ]
        },
        {
          'title': 'Best Sellers / Under Rs. 1000',
          'items': [
            {'name': 'Under Rs. 500', 'subitems': []},
            {'name': 'Under Rs. 750', 'subitems': []},
            {'name': 'Under Rs. 1000', 'subitems': []},
          ]
        },
        {
          'title': 'Gift Guide',
          'isPromo': true,
          'image': 'assets/images/gifts-promo.jpg',
          'cta': 'Gift Guide',
        }
      ]
    },
    'Personalize': {
      'columns': [
        {
          'title': 'Personalization Styles',
          'items': [
            {'name': 'Trapunto', 'subitems': []},
            {'name': 'Handpaint', 'subitems': []},
            {'name': 'Deboss', 'subitems': []},
            {'name': 'Logo', 'subitems': []},
          ]
        },
        {
          'title': 'How It Works',
          'items': [
            {'name': 'Personalization Guide', 'subitems': []},
            {'name': 'Trapunto Guide', 'subitems': []},
            {'name': 'Hand Paint Guide', 'subitems': []},
          ]
        },
        {
          'title': 'Shop Personalized Gifts',
          'isPromo': true,
          'image': 'assets/images/personalize-promo.jpg',
          'cta': 'Shop Personalized Gifts',
        }
      ]
    },
    'Corporate': {
      'columns': [
        {
          'title': 'Programs',
          'items': [
            {'name': 'Bulk Gifting', 'subitems': []},
            {'name': 'Branded Logos', 'subitems': []},
            {'name': 'Custom Designs', 'subitems': []},
          ]
        },
        {
          'title': 'Case Studies / Testimonials',
          'items': [
            {'name': 'Corporate Experience', 'subitems': []},
            {'name': 'Success Stories', 'subitems': []},
          ]
        },
        {
          'title': 'Start a Corporate Order',
          'isPromo': true,
          'image': 'assets/images/corporate-promo.jpg',
          'cta': 'Start a Corporate Order',
        }
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = _megaMenuData[widget.category];
    if (menuData == null) return const SizedBox.shrink();

    return MouseRegion(
      onEnter: (_) {}, // Keep menu open when hovering
      onExit: (_) => widget.onClose(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 600), // Increased height
                decoration: const BoxDecoration(
                  color: AppTheme.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: SingleChildScrollView( // Added scrollable container
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (menuData['columns'] as List).map((column) {
                        return Expanded(
                          child: _buildColumn(column),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColumn(Map<String, dynamic> column) {
    if (column['isPromo'] == true) {
      return _buildPromoColumn(column);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          column['title'],
          style: const TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 16, // Standardized navigation font size
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        ...(column['items'] as List).map((item) {
          return _buildMenuItem(item);
        }),
      ],
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/shop?category=${Uri.encodeComponent(widget.category)}&subcategory=${Uri.encodeComponent(item['name'])}');
              widget.onClose();
            },
            child: Text(
              item['name'],
              style: const TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 16, // Standardized navigation font size
                fontWeight: FontWeight.w400,
                color: AppTheme.textPrimary,
                letterSpacing: 0.2,
              ),
            ),
          ),
          if (item['subitems'] != null && (item['subitems'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: AppTheme.spacingS, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (item['subitems'] as List).map((subitem) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        context.go('/shop?category=${Uri.encodeComponent(widget.category)}&subcategory=${Uri.encodeComponent(item['name'])}&item=${Uri.encodeComponent(subitem)}');
                        widget.onClose();
                      },
                      child: Text(
                        subitem,
                        style: const TextStyle(
                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                          fontSize: 16, // Standardized navigation font size
                          fontWeight: FontWeight.w300,
                          color: AppTheme.textSecondary,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoColumn(Map<String, dynamic> column) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFf6f4f3),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Stack(
        children: [
          // Placeholder for promo image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              color: const Color(0xFFf0f0f0),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 48,
                color: AppTheme.textLight,
              ),
            ),
          ),
          // CTA overlay
          Positioned(
            bottom: AppTheme.spacingM,
            left: AppTheme.spacingM,
            right: AppTheme.spacingM,
            child: ElevatedButton(
              onPressed: () {
                context.go('/shop?category=${Uri.encodeComponent(widget.category)}');
                widget.onClose();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.textPrimary,
                foregroundColor: AppTheme.backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingL,
                  vertical: AppTheme.spacingS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                column['cta'],
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 16, // Standardized navigation font size
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
