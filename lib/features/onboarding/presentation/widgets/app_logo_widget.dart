import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Health',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontFamily: 'Itim',
            fontSize: 28,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'connect',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'Delius Unicase',
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}