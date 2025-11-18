import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF3F7F7B),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE: "Health"
              Text(
                "Health",
                style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                  fontFamily: "Itim",               // custom font
                  fontSize: 36,                     // adjust if Figma states otherwise
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              /// SUBTITLE: dot + "connect"
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Dot
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 6),

                  /// Subtitle text
                  Text(
                    "connect",
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontFamily: "Delius Unicase",  // custom font
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
