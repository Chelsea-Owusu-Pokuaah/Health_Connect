import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class StatusTag extends StatelessWidget {
  final String text;
  final Color? color;

  const StatusTag({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final bg = (color ?? AppColors.primary).withValues(alpha: 0.12);
    final fg = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
