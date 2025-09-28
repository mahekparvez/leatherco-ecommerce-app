import 'package:flutter/material.dart';
import 'announcement_bar.dart';
import 'header.dart';

class StickyHeader extends StatefulWidget {
  const StickyHeader({super.key});

  @override
  State<StickyHeader> createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader> {
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderVisible = true;
  double _lastScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final currentScroll = _scrollController.offset;
      final isScrollingDown = currentScroll > _lastScrollPosition;
      
      if (isScrollingDown && currentScroll > 100) {
        // Hide header when scrolling down past 100px
        if (_isHeaderVisible) {
          setState(() {
            _isHeaderVisible = false;
          });
        }
      } else if (!isScrollingDown || currentScroll <= 100) {
        // Show header when scrolling up or near top
        if (!_isHeaderVisible) {
          setState(() {
            _isHeaderVisible = true;
          });
        }
      }
      
      _lastScrollPosition = currentScroll;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0,
          _isHeaderVisible ? 0 : -120, // Hide both announcement bar and header
          0,
        ),
        child: const Column(
          children: [
            AnnouncementBar(),
            Header(),
          ],
        ),
      ),
    );
  }
}
