import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Avatar + Name + ID
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: const AssetImage(
                'assets/images/avatar_placeholder.png',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kwadwo Agyenim', style: AppTheme.titleStyle),
                const SizedBox(height: 4),
                Text('ID: 23987211', style: AppTheme.captionStyle),
              ],
            ),
          ],
        ),

        /// Notification Bell
        GestureDetector(
        onTap: () => context.go('/notifications'),
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
            Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                ),
                child: Center(
                child: SvgPicture.asset(
                    'assets/icons/bell.svg',
                    width: 26,
                    height: 26,
                ),
                ),
            ),

            Positioned(
                right: -2,
                top: -2,
                child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: const Center(
                    child: Text('1', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                ),
            ),
            ],
        ),
      ),

      ],
    );
  }
}
