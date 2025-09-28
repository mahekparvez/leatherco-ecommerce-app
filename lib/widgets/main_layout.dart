import 'package:flutter/material.dart';
import 'sticky_header.dart';

/// Main layout widget that provides static navigation for all screens
class MainLayout extends StatelessWidget {
  final Widget child;
  final bool showNavigation;

  const MainLayout({
    super.key,
    required this.child,
    this.showNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showNavigation) {
      // For login/register screens, don't show navigation
      return Scaffold(
        body: child,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Main content with padding for fixed header
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80), // Space for fixed header
              child: child,
            ),
          ),
          
          // Fixed header at the top
          const StickyHeader(),
        ],
      ),
    );
  }
}
