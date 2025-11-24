import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/features/doctor_appointments/models/appointment.dart';
import 'package:health_connect/features/doctor_appointments/bloc/doctor_appointments_cubit.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  // 0 -> Upcoming, 1 -> Past, 2 -> Cancelled
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<DoctorAppointmentsCubit>().loadAppointments();
  }

  List<Appointment> _filter(List<Appointment> list) {
    if (_selectedTab == 0) {
      return list.where((a) => a.status == AppointmentStatus.upcoming).toList();
    } else if (_selectedTab == 1) {
      return list.where((a) => a.status == AppointmentStatus.past).toList();
    } else {
      return list.where((a) => a.status == AppointmentStatus.cancelled).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // guard: show this screen only to doctors. Replace with your auth role check.
    final bool isDoctor = true; // TODO: wired to actual auth/user role
    if (!isDoctor) {
      return const Scaffold(
        body: Center(child: Text('Access denied')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('My Appointments', style: AppTheme.titleStyle),
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorAppointmentsCubit, DoctorAppointmentsState>(
        builder: (context, state) {
          if (state is DoctorAppointmentsLoading || state is DoctorAppointmentsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorAppointmentsLoaded) {
            final filtered = _filter(state.appointments);

            return Column(
              children: [
                const SizedBox(height: 8),
                _segmentedControl(),
                const SizedBox(height: 12),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(child: Text('No appointments', style: AppTheme.captionStyle))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            final appt = filtered[idx];
                            return _appointmentCard(appt);
                          },
                        ),
                ),
              ],
            );
          } else if (state is DoctorAppointmentsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _segmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            _tabButton('Upcoming', 0),
            _tabButton('Past', 1),
            _tabButton('Cancelled', 2),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTheme.bodyMedium.copyWith(
                color: active ? Colors.white : AppColors.textPrimary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appointmentCard(Appointment appt) {
    final timeLabel = '${_formatDate(appt.startTime)} • ${_formatTimeRange(appt.startTime, appt.endTime)}';
    return GestureDetector(
      onTap: () {
        // go to patient detail screen
        context.push('/doctor/appointment/${appt.id}', extra: appt);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // placeholder avatar (patient)
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appt.patientName, style: AppTheme.titleStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(timeLabel, style: AppTheme.captionStyle),
                ],
              ),
            ),

            // Call button (doctor-only)
            IconButton(
              onPressed: () {
                // optional: notify cubit that call started
                context.read<DoctorAppointmentsCubit>().startCall(appt);

                // navigate to your shared call screen, pass appointment
                context.push('/call', extra: appt);
              },
              icon: const Icon(Icons.video_call),
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    // simple date formatting — replace with intl if you already use it
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)}';
  }

  String _formatTimeRange(DateTime a, DateTime b) {
    String t1 = '${_two(a.hour)}:${_two(a.minute)}';
    String t2 = '${_two(b.hour)}:${_two(b.minute)}';
    return '$t1 - $t2';
  }

  String _two(int v) => v.toString().padLeft(2, '0');
}
