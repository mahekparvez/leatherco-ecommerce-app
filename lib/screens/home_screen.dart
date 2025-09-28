import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sticky_header.dart';
import '../widgets/hero_banner.dart';
import '../widgets/featured_collections.dart';
import '../widgets/personalization_section.dart';
import '../widgets/footer.dart';
import '../providers/product_provider.dart';
import '../utils/app_theme.dart';

/// Home screen matching Leatherco's exact design and text
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load products when the screen initializes
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: const Column(
        children: [
          // Hero banner - exact Leatherco text
          HeroBanner(
            title: 'Everyday Beauty Heroes',
            subtitle: 'Leather goods that redefine simple everyday luxury',
            buttonText: 'Shop Now',
            backgroundImageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=1400&h=600&fit=crop',
          ),
          
          // Featured collections section
          FeaturedCollections(),
          
          // Personalization section
          PersonalizationSection(),
          
          // Footer
          CustomFooter(),
        ],
      ),
    );
  }
}
