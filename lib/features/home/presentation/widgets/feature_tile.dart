import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String iconAsset;
  final String? badge;
  final VoidCallback? onTap;
  final bool large;

  const FeatureTile._({
    super.key,
    required this.title,
    this.subtitle,
    required this.iconAsset,
    this.badge,
    this.onTap,
    required this.large,
  });

  // SMALL TILE
  factory FeatureTile.small({
    required String title,
    required String iconAsset,
    String? badge,
    VoidCallback? onTap,
  }) {
    return FeatureTile._(
      title: title,
      iconAsset: iconAsset,
      badge: badge,
      onTap: onTap,
      large: false,
    );
  }

  // LARGE TILE
  factory FeatureTile.large({
    required String title,
    String? subtitle,
    required String iconAsset,
    String? badge,
    VoidCallback? onTap,
  }) {
    return FeatureTile._(
      title: title,
      subtitle: subtitle,
      iconAsset: iconAsset,
      badge: badge,
      onTap: onTap,
      large: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return large ? _buildLarge(context) : _buildSmall(context);
  }

  // ----------------------------------------------------------
  // LARGE TILE (60% width, primary background, white text)
  // ----------------------------------------------------------
  Widget _buildLarge(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    final tileWidth = width * 0.6;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: tileWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon top right
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.18),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconAsset,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              title,
              style: AppTheme.titleStyle.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 10),
              Text(
                subtitle!,
                style: AppTheme.captionStyle.copyWith(
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ],

            if (badge != null) ...[
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SMALL TILE (white background)
  // ----------------------------------------------------------
  Widget _buildSmall(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconAsset,
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                const Spacer(),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),

            const Spacer(),

            Text(
              title,
              style: AppTheme.titleStyle.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
