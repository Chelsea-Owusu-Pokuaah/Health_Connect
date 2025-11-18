import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class DoctorSelector extends StatelessWidget {
  final String? selectedDoctorId;
  final void Function(String doctorId) onSelect;

  const DoctorSelector({
    super.key,
    required this.selectedDoctorId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Mock doctor list — replace with real data later
    final doctors = [
      {
        'id': 'd1',
        'name': 'Dr. Chelsea Owusu',
        'specialty': 'Oncologist',
        'avatar':
            'https://images.generated.photos/placeholder1.png', // replace later
      },
      {
        'id': 'd2',
        'name': 'Dr. Thomas Quarshie',
        'specialty': 'Internal Medicine',
        'avatar': null, // shows initials
      },
      {
        'id': 'd3',
        'name': 'Dr. Maya Grant',
        'specialty': 'General Practitioner',
        'avatar': null,
      },
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          final isSelected = doctor['id'] == selectedDoctorId;

          return GestureDetector(
            onTap: () => onSelect(doctor['id']!),
            child: Container(
              width: 85,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 2)
                    : Border.all(color: Colors.transparent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _DoctorAvatar(
                    name: doctor['name']!,
                    avatarUrl: doctor['avatar'],
                    isSelected: isSelected,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    doctor['name']!.split(" ")[1], // last name preview
                    style: AppTheme.captionStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final bool isSelected;

  const _DoctorAvatar({
    required this.name,
    required this.avatarUrl,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name.trim().split(" ").map((e) => e[0]).take(2).join()
        : "?";

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
      ),
      child: ClipOval(
        child: avatarUrl == null
            ? Container(
                color: AppColors.primary.withOpacity(0.25),
                child: Center(
                  child: Text(
                    initials.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
            : Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primary.withOpacity(0.25),
                  child: Center(
                    child: Text(
                      initials.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
