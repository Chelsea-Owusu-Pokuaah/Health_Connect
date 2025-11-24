import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotifications;

  const TopBar({
    super.key,
    required this.title,
    required this.onBack,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back circle
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xFF3F7F7B), // AppColors.primary can be used if available
              ),
            ),
          ),
        ),

        const Expanded(
          child: SizedBox(), // used to center the title
        ),

        Text(
          'Check-up schedule',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const Expanded(
          child: SizedBox(),
        ),

        // Notification icon
        InkWell(
          onTap: onNotifications,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications_none, color: Color(0xFF3F7F7B), size: 20),
                // Red dot
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE94B3C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
