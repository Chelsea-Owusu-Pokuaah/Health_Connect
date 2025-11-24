import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

import '../models/appointment_model.dart';
import 'status_tag.dart';
import 'action_circle_button.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onCall;
  final VoidCallback onChat;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onCall,
    required this.onChat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd/MM/yyyy');
    final timeFmt = DateFormat.jm(); // 3:45 PM

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8)],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // status tag (top-left)
            Row(
              children: [
                StatusTag(text: appointment.statusTag),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              appointment.title,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 14),

            // Date & Time row
            Row(
              children: [
                // Date block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DATE',
                          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 0.6,
                          )),
                      const SizedBox(height: 6),
                      Text(dateFmt.format(appointment.dateTime),
                          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                ),

                // Time block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TIME',
                          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 0.6,
                          )),
                      const SizedBox(height: 6),
                      Text(timeFmt.format(appointment.dateTime),
                          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            const SizedBox(height: 12),

            // Doctor row
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: appointment.doctorAvatarUrl != null
                      ? NetworkImage(appointment.doctorAvatarUrl!)
                      : const AssetImage('assets/images/doctor_placeholder.png')
                          as ImageProvider,
                ),

                const SizedBox(width: 12),

                // Name & specialty
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment.doctorSpecialty,
                        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Action icons
                Row(
                  children: [
                    ActionCircleButton(
                      onTap: onCall,
                      child: const Icon(
                        Icons.call,
                        color: Color(0xFF3F7F7B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ActionCircleButton(
                      onTap: onChat,
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF3F7F7B),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
