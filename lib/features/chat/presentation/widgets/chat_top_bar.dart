import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class ChatTopBar extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String? avatarUrl;
  final bool isOnline;

  const ChatTopBar({
    super.key,
    required this.doctorName,
    required this.specialty,
    this.avatarUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // BACK BUTTON
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, size: 22),
          ),
        ),

        const SizedBox(width: 14),

        // AVATAR + NAME + STATUS
        Expanded(
          child: Row(
            children: [
              // AVATAR
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  image: avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/avatar_placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              // TEXT INFO
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: AppTheme.titleStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // ONLINE DOT
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isOnline ? "Online" : "Offline",
                        style: AppTheme.captionStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),

        // THREE-DOTS MORE MENU
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.more_vert, size: 22),
        ),
      ],
    );
  }
}
