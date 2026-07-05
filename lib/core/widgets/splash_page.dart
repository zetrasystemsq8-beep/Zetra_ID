import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/router/app_router.dart';

/// Splash screen page that displays an animated application logo.
///
/// Features:
/// - Smooth fade + scale animation.
/// - Automatically switches between light and dark logos depending
///   on the active theme.
/// - Navigates to the shell/root page after a short delay.
///
/// This widget is shown only once when the app starts.
class SplashScreen extends StatefulWidget {
  /// Route name for use with navigation.
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  /// Controller driving fade + scale animations.
  late final AnimationController _controller;

  /// Fade animation from 0 → 1.
  late final Animation<double> _fade;

  /// Scale animation (slight enlargement effect).
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // Animation controller for splash logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Fade animation
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Scale animation
    _scale = Tween<double>(begin: 0.85, end: 1.07).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    // Navigate to shell page after animation finishes
    Timer(const Duration(milliseconds: 1900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.shell);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Image.asset(
              isDark
                  ? 'assets/images/logo-dark.png'
                  : 'assets/images/logo.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}
