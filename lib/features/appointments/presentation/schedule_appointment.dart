import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Update these imports if your theme files live in a different path.
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

import 'models/appointment_model.dart';
import 'widgets/top_bar.dart';
import 'widgets/segmented_control.dart';
import 'widgets/appointment_card.dart';
import 'widgets/empty_state.dart';

/// Main screen: ScheduleAppointmentScreen
/// This is a UI-only implementation with placeholder/mock data.
/// Replace the mock data section with your BLoC or repository calls.
class ScheduleAppointmentScreen extends StatefulWidget {
  const ScheduleAppointmentScreen({super.key});

  @override
  State<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  int _selectedIndex = 0; // 0 = Upcoming, 1 = History

  // Page-local mock data. Replace with BLoC-provided list or pass via constructor.
  late final List<Appointment> _upcomingMock;
  late final List<Appointment> _historyMock;

  @override
  void initState() {
    super.initState();

    // Mock data for preview — replace with real cloud-sourced data via BLoC.
    _upcomingMock = [
      Appointment(
        id: 'a1',
        title: 'Online consultation: Prostate results',
        dateTime: DateTime(2025, 11, 27, 10, 15),
        statusTag: 'SOON',
        doctorName: 'Dr. Chelsea Owusu',
        doctorSpecialty: 'Oncologist',
        doctorAvatarUrl:
            'https://example.com/avatars/chelsea.png', // replace with real URL
        isVideoAvailable: true,
      ),
      Appointment(
        id: 'a2',
        title: 'Online check-in: Ulcer issues',
        dateTime: DateTime(2025, 12, 6, 15, 45),
        statusTag: 'NEXT WEEK',
        doctorName: 'Dr. Thomas Quarshie',
        doctorSpecialty: 'Internal Medicine',
        doctorAvatarUrl:
            'https://example.com/avatars/thomas.png', // replace with real URL
        isVideoAvailable: true,
      ),
    ];

    _historyMock = [
      Appointment(
        id: 'h1',
        title: 'Follow-up: Bloodwork review',
        dateTime: DateTime(2025, 9, 10, 9, 0),
        statusTag: 'COMPLETED',
        doctorName: 'Dr. Jane Doe',
        doctorSpecialty: 'Pathology',
        doctorAvatarUrl: null,
      ),
    ];
  }

  void _onBack() => context.go('/home');

  void _onNotifications() => context.go('/notifications');

  void _onSegmentChanged(int idx) => setState(() => _selectedIndex = idx);

  void _onCall(Appointment appt) {
    // Hook for phone/call logic
    // e.g., context.read<CallBloc>().startCall(appt)
    debugPrint('Call ${appt.doctorName}');
  }

  void _onChat(Appointment appt) {
    // Hook to navigate to chat screen
    context.go('/chat/${appt.id}');
  }

  void _onTapCard(Appointment appt) {
    // Navigate to appointment detail
    context.go('/appointments/${appt.id}');
  }

  @override
  Widget build(BuildContext context) {
    // Replace these with theme-based sizes if available
    final horizontalPadding = 20.0;

    // Replace mock lists with BLoC results:
    // e.g. final upcoming = context.select((AppointmentBloc b) => b.state.upcoming);
    final items = _selectedIndex == 0 ? _upcomingMock : _historyMock;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
              child: TopBar(
                title: 'Check-up schedule',
                onBack: _onBack,
                onNotifications: _onNotifications,
              ),
            ),

            // Segmented control
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: SegmentedControl(
                items: const ['Upcoming', 'History'],
                currentIndex: _selectedIndex,
                onChanged: _onSegmentChanged,
              ),
            ),

            const SizedBox(height: 16),

            // List of cards
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: items.isEmpty
                    ? const EmptyState(
                        title: 'No appointments',
                        subtitle: 'You have no appointments in this list.',
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, idx) {
                          final appt = items[idx];
                          return AppointmentCard(
                            appointment: appt,
                            onCall: () => _onCall(appt),
                            onChat: () => _onChat(appt),
                            onTap: () => _onTapCard(appt),
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
