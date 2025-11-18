import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class ReasonField extends StatelessWidget {
  final void Function(String) onChanged;
  final VoidCallback? onVoiceTap;

  const ReasonField({
    super.key,
    required this.onChanged,
    this.onVoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTheme.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type a reason...",
                hintStyle: AppTheme.captionStyle,
              ),
            ),
          ),

          // Voice recording icon
          GestureDetector(
            onTap: onVoiceTap ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Voice recording not implemented yet."),
                    ),
                  );
                },
            child: SvgPicture.asset(
              "assets/icons/mic.svg",
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
