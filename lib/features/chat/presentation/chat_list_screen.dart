import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/features/home/presentation/widgets/bottom_nav_bar.dart';

import 'models/chat_participant.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // TEMP MOCK DATA
    final doctors = [
      ChatParticipant(
        id: "d1",
        name: "Dr. Angela Sarpong",
        role: "doctor",
        avatarUrl: null,
        isOnline: true,
      ),
      ChatParticipant(
        id: "d2",
        name: "Dr. Mike Boateng",
        role: "doctor",
        avatarUrl: null,
        isOnline: false,
      ),
      ChatParticipant(
        id: "d3",
        name: "Dr. Ama Serwaa",
        role: "doctor",
        avatarUrl: null,
        isOnline: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [

            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => context.go('/home'),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),

                  Text(
                    "Messages",
                    style: AppTheme.titleStyle.copyWith(fontSize: 22),
                  ),

                  // Notification bell
                  GestureDetector(
                    onTap: () => context.go('/notifications'),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/bell.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // LIST
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: doctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];

                  return GestureDetector(
                    onTap: () {
                      context.goNamed(
                        'chat_detail',
                        extra: doctor,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/avatar_placeholder.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Name & Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: AppTheme.titleStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doctor.isOnline
                                      ? "Online now"
                                      : "Offline",
                                  style: AppTheme.captionStyle,
                                ),
                              ],
                            ),
                          ),

                          // Green dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: doctor.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: const SafeArea(
        child: BottomNavBar(),
      ),
    );
  }
}
