import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Footer widget matching Leatherology's exact design
class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2C2C2C),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXXL,
        vertical: AppTheme.spacingXXL,
      ),
      child: Column(
        children: [
          // Main footer content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Care
              Expanded(
                child: _buildFooterColumn(
                  title: 'Customer Care',
                  items: [
                    'Contact Us',
                    'Shipping',
                    'Returns',
                    'Track My Order',
                    'Press Inquiries',
                    'FAQ',
                    'Catalog Unsubscribe',
                    'Promo Details',
                  ],
                ),
              ),
              
              // About Us
              Expanded(
                child: _buildFooterColumn(
                  title: 'About Us',
                  items: [
                    'About Leatherology',
                    'Our Leathers',
                    'Leather Care',
                    'Canvas Care',
                    'Testimonials',
                    'Careers',
                    'Affiliates',
                    'Stories',
                  ],
                ),
              ),
              
              // Services
              Expanded(
                child: _buildFooterColumn(
                  title: 'Services',
                  items: [
                    'Personalization',
                    'Trapunto',
                    'Deboss Monogramming',
                    'Hand Paint',
                    'Personalization FAQ',
                    'Gift Cards',
                    'Corporate Orders',
                  ],
                ),
              ),
              
              // Connect section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connect With Us Online!',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingL),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.facebook),
                        const SizedBox(width: AppTheme.spacingM),
                        _buildSocialIcon(Icons.camera_alt), // Instagram alternative
                        const SizedBox(width: AppTheme.spacingM),
                        _buildSocialIcon(Icons.push_pin), // Pinterest alternative
                        const SizedBox(width: AppTheme.spacingM),
                        _buildSocialIcon(Icons.email),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingXXL),
          
          // Bottom section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2025 Leatherology',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Accessibility Adjustments',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn({
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 18, // Slightly bigger
            fontWeight: FontWeight.w400,
            color: Colors.white,
            decoration: TextDecoration.underline, // Add underline
            decorationColor: Colors.white,
            decorationThickness: 1.0,
          ),
        ),
        const SizedBox(height: AppTheme.spacingL),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              item,
              style: const TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
