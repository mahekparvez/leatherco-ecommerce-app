import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import 'mega_menu.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String? _hoveredCategory;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchOpen = false;

  // Navigation items matching Leatherology exactly
  final List<String> _navItems = [
    'Women',
    'Men', 
    'Home & Office',
    'Sport',
    'Travel',
    'Gifts',
    'Personalize',
    'Corporate'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() {
      _isSearchOpen = true;
    });
    // TODO: Implement full-screen search overlay
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: Column(
        children: [
          // Main header row
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor,
              border: Border(
                bottom: BorderSide(color: AppTheme.borderColor, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Logo
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: Text(
                    'LEATHERCO',
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                      fontSize: 24, // Increased from 18
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Navigation items
                Row(
                  children: _navItems.map((item) {
                    return _buildNavItem(item);
                  }).toList(),
                ),
                
                const Spacer(),
                
                // Right side content
                Row(
                  children: [
                    // Search icon
                    IconButton(
                      onPressed: _openSearch,
                      icon: const Icon(
                        Icons.search,
                        size: 24,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    
                    const SizedBox(width: AppTheme.spacingS),
                    
                    // Account icon
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        if (authProvider.isAuthenticated) {
                          return PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.person_outline,
                              size: 24,
                              color: AppTheme.textPrimary,
                            ),
                            onSelected: (value) {
                              if (value == 'logout') {
                                authProvider.signOut();
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'profile',
                                child: Text('Profile'),
                              ),
                              const PopupMenuItem(
                                value: 'orders',
                                child: Text('Orders'),
                              ),
                              const PopupMenuItem(
                                value: 'logout',
                                child: Text('Logout'),
                              ),
                            ],
                          );
                        } else {
                          return IconButton(
                            onPressed: () => context.go('/login'),
                            icon: const Icon(
                              Icons.person_outline,
                              size: 24,
                              color: AppTheme.textPrimary,
                            ),
                          );
                        }
                      },
                    ),
                    
                    const SizedBox(width: AppTheme.spacingS),
                    
                    // Cart icon with badge
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
                  ],
                ),
              ],
            ),
          ),
          
          // Mega menu dropdown
          if (_hoveredCategory != null)
            MegaMenu(
              category: _hoveredCategory!,
              onClose: () => setState(() => _hoveredCategory = null),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String item) {
    final isHovered = _hoveredCategory == item;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCategory = item),
      onExit: (_) => setState(() => _hoveredCategory = null),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 16, // Standardized navigation font size
                fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.5,
                color: AppTheme.textPrimary,
              ),
              child: Text(item),
            ),
            
            const SizedBox(height: 8), // Added gap between text and underline
            
            // Hover underline animation - 1/4th the size of the word
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 3,
              width: isHovered ? (item.length * 4.5) : 0, // 1/4th the size of the word
              decoration: const BoxDecoration(
                color: Color(0xFF2C160B), // Leatherology's dark brown
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1.5),
                  topRight: Radius.circular(1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
