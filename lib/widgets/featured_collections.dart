import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';

/// Featured collections widget matching Leatherco's exact design and text
class FeaturedCollections extends StatelessWidget {
  const FeaturedCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
        vertical: AppTheme.spacingXXL,
      ),
      child: Column(
        children: [
          // Color showcase section - exact Leatherco text and styling
          _buildColorShowcase(context),
          
          const SizedBox(height: AppTheme.spacingXXXL),
          
          // Willow Collection - exact Leatherco text and styling
          _buildWillowCollection(context),
          
          const SizedBox(height: AppTheme.spacingXXXL),
          
          // What's Trending - exact Leatherco text and styling
          _buildTrendingSection(context),
        ],
      ),
    );
  }

  Widget _buildColorShowcase(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildColorCard(
            context: context,
            title: 'Earthy & Understated',
            subtitle: 'Add a natural calm to any carry with our newest neutral.',
            buttonText: 'Shop More',
            imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&h=400&fit=crop',
          ),
        ),
        const SizedBox(width: AppTheme.spacingL),
        Expanded(
          child: _buildColorCard(
            context: context,
            title: 'Golden Hour',
            subtitle: 'The sun-warmed browns for workdays and weekends!',
            buttonText: 'Shop More',
            imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&h=400&fit=crop',
          ),
        ),
      ],
    );
  }

  Widget _buildColorCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String buttonText,
    required String imageUrl,
  }) {
    return Container(
      height: 400, // Exact Leatherology height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 32, // Increased from 24
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 18, // Increased from 14
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 0.1,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/shop?category=By Color');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingL,
                      vertical: AppTheme.spacingS,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // No border radius like Leatherology
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                      fontSize: 16, // Increased from 12
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textPrimary,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWillowCollection(BuildContext context) {
    return Container(
      height: 500, // Exact Leatherology height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=1200&h=500&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'The Willow Collection',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 42, // Increased from 32
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              const Text(
                'Explore envelope silhouettes that go from dream crossbody to dream clutch.',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 20, // Increased from 16
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 0.1,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppTheme.spacingL),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/shop?category=Women');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXL,
                      vertical: AppTheme.spacingM,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // No border radius like Leatherology
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                      fontSize: 18, // Increased from 14
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textPrimary,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's Trending",
          style: TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 32, // Increased from 24
            fontWeight: FontWeight.w300,
            color: AppTheme.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppTheme.spacingL),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppTheme.spacingL,
            mainAxisSpacing: AppTheme.spacingL,
            childAspectRatio: 0.85, // Adjusted aspect ratio to prevent overflow
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            // Exact Leatherco trending products
            final products = [
              {'name': 'Meadow Double Zip Camera Bag', 'price': 'Rs. 700'},
              {'name': 'Bifold Wallet', 'price': 'Rs. 700'},
              {'name': 'Transit Travel Tote', 'price': 'Rs. 700'},
              {'name': 'A5 2-in-1 Journal Gift Set', 'price': 'Rs. 700'},
            ];
            
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.go('/product/$index');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fixed height image container for consistent image-to-text ratio
                      Container(
                        height: 200, // Fixed height for all images
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppTheme.radiusL),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300&h=300&fit=crop'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Fixed height text container for consistent layout
                      Container(
                        height: 100, // Increased height to fix overflow
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              products[index]['name']!,
                              style: const TextStyle(
                                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                fontSize: 16, // Standardized font size
                                fontWeight: FontWeight.w300,
                                color: AppTheme.textPrimary,
                                letterSpacing: 0.1,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              products[index]['price']!,
                              style: const TextStyle(
                                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                fontSize: 16, // Standardized font size
                                fontWeight: FontWeight.w400,
                                color: AppTheme.textPrimary,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
