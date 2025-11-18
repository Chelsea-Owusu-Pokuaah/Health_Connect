import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

// Local widgets
import 'widgets/doctor_selector.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/time_slot_selector.dart';
import 'widgets/reason_field.dart';

// Reuse your existing TopBar
import 'widgets/top_bar.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedDoctorId;
  DateTime? selectedDate;
  String? selectedTimeSlot;
  String reason = "";

  void _onBook() {
    if (selectedDoctorId == null ||
        selectedDate == null ||
        selectedTimeSlot == null ||
        reason.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields.")),
      );
      return;
    }

    // Success navigation
    context.push('/schedule');
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = 20.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                title: "Book Appointment",
                onBack: () => context.pop(),
                onNotifications: () => context.go('/notifications'),
              ),

              const SizedBox(height: 24),

              // -----------------
              // SELECT DOCTOR
              // -----------------
              Text(
                "Select Doctor",
                style: AppTheme.titleStyle,
              ),
              const SizedBox(height: 12),

              DoctorSelector(
                selectedDoctorId: selectedDoctorId,
                onSelect: (id) => setState(() => selectedDoctorId = id),
              ),

              const SizedBox(height: 28),

              // -----------------
              // SELECT DATE
              // -----------------
              Text(
                "Select Date",
                style: AppTheme.titleStyle,
              ),
              const SizedBox(height: 12),

              DatePickerField(
                selectedDate: selectedDate,
                onSelect: (date) => setState(() => selectedDate = date),
              ),

              const SizedBox(height: 28),

              // -----------------
              // SELECT TIME
              // -----------------
              Text(
                "Select Time",
                style: AppTheme.titleStyle,
              ),
              const SizedBox(height: 12),

              TimeSlotSelector(
                selectedSlot: selectedTimeSlot,
                onSelect: (slot) => setState(() => selectedTimeSlot = slot),
              ),

              const SizedBox(height: 28),

              // -----------------
              // REASON FIELD
              // -----------------
              Text(
                "Reason for appointment",
                style: AppTheme.titleStyle,
              ),
              const SizedBox(height: 12),

              ReasonField(
                onChanged: (val) => reason = val,
              ),

              const SizedBox(height: 40),

              // -----------------
              // BOOK BUTTON
              // -----------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onBook,
                  child: const Text("Book Appointment"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
