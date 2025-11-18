import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  Widget _buildDot(bool active) {
    return Container(
      width: active ? 20 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : const Color(0xFFD6D6D6),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (i) => _buildDot(i == currentIndex)),
    );
  }
}