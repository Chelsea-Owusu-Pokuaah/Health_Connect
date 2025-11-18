import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Illustration
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: (svgAsset.endsWith('.svg')
                    ? SvgPicture.asset(
                        svgAsset,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )
                  : Image.asset(
                      svgAsset,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary),
          ),

          const SizedBox(height: 12),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}