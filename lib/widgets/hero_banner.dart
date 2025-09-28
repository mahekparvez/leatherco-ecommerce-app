import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';

/// Hero banner widget matching Leatherology's exact design and text
class HeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String backgroundImageUrl;

  const HeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.backgroundImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Exact Leatherology height
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main title - exact Leatherology text and styling
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                  fontSize: 64, // Increased from 48
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 1.0,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Subtitle - exact Leatherology text and styling
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                    fontSize: 24, // Increased from 18
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    letterSpacing: 0.3,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingXL),
              
              // CTA buttons - exact Leatherology layout with overflow protection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppTheme.spacingM,
                  runSpacing: AppTheme.spacingM,
                  children: [
                    _buildShopButton(context),
                    _buildCategoryButtons(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () {
          context.go('/shop');
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
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 18, // Increased from 14
            fontWeight: FontWeight.w400,
            color: AppTheme.textPrimary,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppTheme.spacingM,
      runSpacing: AppTheme.spacingS,
      children: [
        _buildCategoryButton(context, 'Women'),
        _buildCategoryButton(context, 'Men'),
        _buildCategoryButton(context, 'Home & Office'),
        _buildCategoryButton(context, 'Travel'),
      ],
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: () {
          context.go('/shop?category=${Uri.encodeComponent(category)}');
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingS,
          ),
        ),
        child: Text(
          category,
          style: const TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 18, // Increased from 14
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
