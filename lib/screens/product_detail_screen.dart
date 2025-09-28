import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "../widgets/sticky_header.dart";
import '../widgets/navigation_bar.dart';
import '../widgets/footer.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../utils/app_theme.dart';

/// Product detail screen showing full product information
/// Includes image gallery, product details, specifications, and add to cart
class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    // Load products if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<ProductProvider>();
      if (productProvider.products.isEmpty) {
        productProvider.loadProducts();
      }
    });
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
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                final product = productProvider.getProductById(widget.productId);
                
                if (product == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  );
                }
                
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Product details
                      _buildProductDetails(product),
                      
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

  /// Build product details section
  Widget _buildProductDetails(product) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
        vertical: AppTheme.spacingXXL,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product images
          Expanded(
            flex: 1,
            child: _buildProductImages(product),
          ),
          
          const SizedBox(width: AppTheme.spacingXXL),
          
          // Product information
          Expanded(
            flex: 1,
            child: _buildProductInfo(product),
          ),
        ],
      ),
    );
  }

  /// Build product images section
  Widget _buildProductImages(product) {
    final images = [product.imageUrl];
    if (product.additionalImages != null) {
      images.addAll(product.additionalImages!);
    }

    return Column(
      children: [
        // Main image
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
            color: AppTheme.surfaceColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
            child: CachedNetworkImage(
              imageUrl: images[_selectedImageIndex],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.surfaceColor,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.surfaceColor,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AppTheme.textLight,
                  size: 64,
                ),
              ),
            ),
          ),
        ),
        
        if (images.length > 1) ...[
          const SizedBox(height: AppTheme.spacingL),
          // Thumbnail images
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: AppTheme.spacingM),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      border: Border.all(
                        color: _selectedImageIndex == index 
                            ? AppTheme.primaryColor 
                            : AppTheme.borderColor,
                        width: _selectedImageIndex == index ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppTheme.surfaceColor,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppTheme.surfaceColor,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppTheme.textLight,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  /// Build product information section
  Widget _buildProductInfo(product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product name
        Text(
          product.name,
          style: AppTheme.heading2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingM),
        
        // Product price
        Text(
          'Rs. ${product.price.toStringAsFixed(0)}',
          style: AppTheme.heading4.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingL),
        
        // Product description
        Text(
          product.description,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
            height: 1.6,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingXL),
        
        // Quantity selector
        Row(
          children: [
            Text(
              'Quantity:',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppTheme.spacingL),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.borderColor),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _quantity > 1 ? () {
                      setState(() {
                        _quantity--;
                      });
                    } : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                    ),
                    child: Text(
                      '$_quantity',
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacingXL),
        
        // Add to cart button
        Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final isInCart = cartProvider.isInCart(product.id);
            
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addItem(product, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInCart ?
                      AppTheme.secondaryColor 
                      : AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacingL,
                  ),
                ),
                child: Text(
                  isInCart ? 'ADDED TO CART' : 'ADD TO CART',
                  style: AppTheme.button.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: AppTheme.spacingXL),
        
        // Product specifications
        if (product.specifications != null) ...[
          Text(
            'SPECIFICATIONS',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          ...product.specifications.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${entry.key}:',
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value.toString(),
                      style: AppTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    );
  }
}
