import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_theme.dart';

/// Personalization section widget matching Leatherology's exact design and text
class PersonalizationSection extends StatelessWidget {
  const PersonalizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
        vertical: AppTheme.spacingXXL,
      ),
      child: Column(
        children: [
          // Main personalization section - exact Leatherology text and styling
          Container(
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
                      'Make It Personal',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    const Text(
                      'Unique people should have unique things. Create something one of a kind that lasts a lifetime.',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                        fontSize: 20, // Bigger font size
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 0.1,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingL),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/shop?category=Personalize');
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
                          'Learn More',
                          style: TextStyle(
                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                            fontSize: 14,
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
          ),
          
          const SizedBox(height: AppTheme.spacingXXXL),
          
          // Beliefs section - exact Leatherology text and styling
          _buildBeliefsSection(context),
        ],
      ),
    );
  }

  Widget _buildBeliefsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'At Leatherco, we believe in:',
          style: TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 24,
            fontWeight: FontWeight.w300,
            color: AppTheme.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXL),
        
        Row(
          children: [
            Expanded(
              child: _buildBeliefCard(
                context: context,
                title: 'Personalization That Pops',
                description: 'Limitless options to make it yours with hand deboss or hand painting.',
                imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
              ),
            ),
            const SizedBox(width: AppTheme.spacingL),
            Expanded(
              child: _buildBeliefCard(
                context: context,
                title: 'Timeless Leathers',
                description: 'Timeless styles made fresh with an ever-changing color assortment.',
                imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
              ),
            ),
            const SizedBox(width: AppTheme.spacingL),
            Expanded(
              child: _buildBeliefCard(
                context: context,
                title: 'Finishing Touches',
                description: 'Complimentary gift packaging for beautifully packaged everyday luxury.',
                imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBeliefCard({
    required BuildContext context,
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200, // Exact Leatherology height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: AppTheme.textPrimary,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: AppTheme.textSecondary,
            letterSpacing: 0.1,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TextButton(
            onPressed: () {
              context.go('/shop?category=Personalize');
            },
            child: const Text(
              'Learn More',
              style: TextStyle(
                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.textPrimary,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
