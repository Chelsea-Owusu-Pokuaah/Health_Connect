import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/features/doctor_appointments/models/appointment.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;
  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Appointment Details', style: AppTheme.titleStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/avatar_placeholder.png')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.patientName, style: AppTheme.headingStyle.copyWith(fontSize: 20)),
                      const SizedBox(height: 6),
                      Text(appointment.reason, style: AppTheme.captionStyle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Date & Time', style: AppTheme.titleStyle),
            const SizedBox(height: 8),
            Text('${appointment.startTime} - ${appointment.endTime}', style: AppTheme.bodyMedium),
            const SizedBox(height: 18),
            Text('Status', style: AppTheme.titleStyle),
            const SizedBox(height: 8),
            Text(appointment.status.toString().split('.').last, style: AppTheme.captionStyle),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // start call
                      context.push('/call', extra: appointment);
                    },
                    icon: const Icon(Icons.video_call),
                    label: const Text('Start Video Call'),
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
