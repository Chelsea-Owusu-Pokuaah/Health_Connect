import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool filled;
  final bool enabled;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.filled = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = filled ? AppColors.primary : AppColors.surface;
    final textColor = filled ? Colors.white : AppColors.primary;
    final opacity = enabled ? 1.0 : 0.5;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
