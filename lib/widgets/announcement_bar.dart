import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../utils/app_theme.dart';

class AnnouncementBar extends StatefulWidget {
  const AnnouncementBar({super.key});

  @override
  State<AnnouncementBar> createState() => _AnnouncementBarState();
}

class _AnnouncementBarState extends State<AnnouncementBar> {
  bool _isVisible = true;
  bool _isDismissed = false;
  late ScrollController _scrollController;
  bool _isScrollingDown = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _checkDismissedStatus();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final currentScroll = _scrollController.offset;
      final isScrollingDown = currentScroll > 0;
      
      if (isScrollingDown != _isScrollingDown) {
        setState(() {
          _isScrollingDown = isScrollingDown;
        });
        
        if (isScrollingDown) {
          // Hide announcement bar when scrolling down
          _hideTimer?.cancel();
          _hideTimer = Timer(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() {
                _isVisible = false;
              });
            }
          });
        } else {
          // Show announcement bar when scrolling up
          _hideTimer?.cancel();
          setState(() {
            _isVisible = true;
          });
        }
      }
    }
  }

  Future<void> _checkDismissedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final dismissed = prefs.getBool('announcement_dismissed') ?? false;
    final dismissedTime = prefs.getInt('announcement_dismissed_time') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    // Show again after 7 days
    if (dismissed && (now - dismissedTime) > 7 * 24 * 60 * 60 * 1000) {
      await prefs.remove('announcement_dismissed');
      await prefs.remove('announcement_dismissed_time');
      setState(() {
        _isDismissed = false;
      });
    } else {
      setState(() {
        _isDismissed = dismissed;
      });
    }
  }

  Future<void> _dismissAnnouncement() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('announcement_dismissed', true);
    await prefs.setInt('announcement_dismissed_time', DateTime.now().millisecondsSinceEpoch);
    
    setState(() {
      _isDismissed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isVisible ? 40 : 0,
      child: Container(
        width: double.infinity,
        height: 40,
        color: const Color(0xFFf6f4f3), // Leatherology's announcement bar color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Promo text
            const Expanded(
              child: Center(
                child: Text(
                  'Sign up to receive 10% off your first order • Free India shipping on orders above Rs. 2500',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: AppTheme.textPrimary,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Dismiss button
            GestureDetector(
              onTap: _dismissAnnouncement,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
