import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'widgets/app_logo_widget.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/primary_button.dart';
import 'package:health_connect/features/onboarding/presentation/onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSkip() {
    // Navigate to login when skipping
    context.go('/login');
  }

  void _onGetStarted() {
    // Final page action
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 24.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),
            const AppLogoWidget(),
            const SizedBox(height: 12),

            // PageView area
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                children: [
                  // Page 1
                  OnboardingPage(
                    svgAsset: 'assets/images/onboarding_1.svg',
                    title: 'Welcome to Health Connect',
                    subtitle:
                        'On Call Doctors ready to serve you,\ngiving you the best quality of healthcare services',
                  ),

                  // Page 2
                  OnboardingPage(
                    svgAsset: 'assets/images/onboarding_2.png',
                    title: 'Save Time, Save Money',
                    subtitle: 'Consultation on the go.',
                  ),
                ],
              ),
            ),

            // Indicators
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  OnboardingIndicator(currentIndex: _currentIndex, itemCount: 2),
                  const SizedBox(height: 18),

                  // Bottom button
                  PrimaryButton(
                    text: _currentIndex == 1 ? 'Get Started' : 'Skip',
                    onTap: _currentIndex == 1 ? _onGetStarted : _onSkip,
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}