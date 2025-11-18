import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:go_router/go_router.dart';

class IncomingCallScreen extends StatelessWidget {
  final String doctorName;
  final String? doctorAvatar;

  const IncomingCallScreen({
    super.key,
    required this.doctorName,
    this.doctorAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DOCTOR AVATAR
            CircleAvatar(
              radius: 60,
              backgroundImage: doctorAvatar != null
                  ? NetworkImage(doctorAvatar!)
                  : const AssetImage("assets/images/avatar_placeholder.png")
                      as ImageProvider,
            ),

            const SizedBox(height: 24),

            // DOCTOR NAME
            Text(
              doctorName,
              style: AppTheme.titleStyle.copyWith(fontSize: 22),
            ),

            const SizedBox(height: 8),

            // CALL TYPE TEXT
            Text(
              "Incoming video call...",
              style: AppTheme.captionStyle.copyWith(fontSize: 16),
            ),

            const SizedBox(height: 40),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // DECLINE
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),

                const SizedBox(width: 40),

                // ACCEPT
                GestureDetector(
                  onTap: () => context.go('/appointment_call'),
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
