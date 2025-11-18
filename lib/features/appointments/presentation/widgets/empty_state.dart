import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyState({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today, size: 48, color: AppColors.primary.withOpacity(0.14)),
          const SizedBox(height: 12),
          Text(title, style: AppTheme.lightTheme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
