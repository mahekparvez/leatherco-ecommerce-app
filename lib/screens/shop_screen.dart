import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sticky_header.dart';
import '../widgets/product_card.dart';
import '../widgets/footer.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../utils/app_theme.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedCategory;
  String? _searchQuery;
  String _sortBy = 'default';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Breadcrumb and title
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Breadcrumb
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.go('/'),
                                  child: Text(
                                    'Home',
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ),
                                const Text(' / ', style: TextStyle(color: AppTheme.textSecondary)),
                                Text(
                                  _selectedCategory ?? 'All Products',
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            
                            // Title
                            Text(
                              _selectedCategory ?? 'All Products',
                              style: const TextStyle(
                                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            
                            // Product count
                            Consumer<ProductProvider>(
                              builder: (context, productProvider, child) {
                                final products = _getFilteredProducts(productProvider.products);
                                return Text(
                                  '${products.length} products',
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppTheme.textSecondary,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      // Filters and sort
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
                        child: Row(
                          children: [
                            // Category filter
                            DropdownButton<String>(
                              value: _selectedCategory,
                              hint: const Text('All Categories'),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                              items: [
                                const DropdownMenuItem(value: null, child: Text('All Categories')),
                                const DropdownMenuItem(value: 'Women', child: Text('Women')),
                                const DropdownMenuItem(value: 'Men', child: Text('Men')),
                                const DropdownMenuItem(value: 'Home & Office', child: Text('Home & Office')),
                                const DropdownMenuItem(value: 'Travel', child: Text('Travel')),
                                const DropdownMenuItem(value: 'Gifts', child: Text('Gifts')),
                              ],
                            ),
                            
                            const Spacer(),
                            
                            // Sort dropdown
                            DropdownButton<String>(
                              value: _sortBy,
                              onChanged: (value) {
                                setState(() {
                                  _sortBy = value!;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: 'default', child: Text('Default')),
                                DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                                DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                                DropdownMenuItem(value: 'name', child: Text('Name A-Z')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: AppTheme.spacingL),
                      
                      // Products grid
                      Consumer<ProductProvider>(
                        builder: (context, productProvider, child) {
                          final products = _getFilteredProducts(productProvider.products);
                          final sortedProducts = _sortProducts(products);
                          
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: AppTheme.spacingM,
                              mainAxisSpacing: AppTheme.spacingM,
                            ),
                            itemCount: sortedProducts.length,
                            itemBuilder: (context, index) {
                              final product = sortedProducts[index];
                              return ProductCard(product: product);
                            },
                          );
                        },
                      ),
                      
                      const SizedBox(height: AppTheme.spacingXL),
                      
                      // Footer
                      const CustomFooter(),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  List<Product> _getFilteredProducts(List<Product> products) {
    var filtered = products;
    
    if (_selectedCategory != null) {
      filtered = filtered.where((p) => p.category == _selectedCategory).toList();
    }
    
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      filtered = filtered.where((p) => 
        p.name.toLowerCase().contains(_searchQuery!.toLowerCase()) ||
        p.description.toLowerCase().contains(_searchQuery!.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  List<Product> _sortProducts(List<Product> products) {
    switch (_sortBy) {
      case 'price_low':
        return List.from(products)..sort((a, b) => a.price.compareTo(b.price));
      case 'price_high':
        return List.from(products)..sort((a, b) => b.price.compareTo(a.price));
      case 'name':
        return List.from(products)..sort((a, b) => a.name.compareTo(b.name));
      default:
        return products;
    }
  }
}
