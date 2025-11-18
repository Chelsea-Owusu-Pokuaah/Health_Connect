import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime) onSelect;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onSelect,
  });

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) onSelect(picked);
  }

  @override
  Widget build(BuildContext context) {
    final formatted = selectedDate == null
        ? "Select a date"
        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";

    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/calendar.svg",
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              formatted,
              style: AppTheme.bodyMedium.copyWith(
                color: selectedDate == null
                    ? AppColors.textSecondary
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
