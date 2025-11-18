import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

import '../../chat/presentation/models/chat_participant.dart';

class CallConnectingScreen extends StatelessWidget {
  final ChatParticipant doctor;

  const CallConnectingScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Doctor avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: doctor.avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(doctor.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage(
                            'assets/images/avatar_placeholder.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // Doctor name
              Text(
                doctor.name,
                style: AppTheme.titleStyle.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 8),

              // Connecting status
              Text(
                "Connecting…",
                style: AppTheme.captionStyle.copyWith(fontSize: 16),
              ),

              const SizedBox(height: 40),

              // Cancel Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel Call",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
