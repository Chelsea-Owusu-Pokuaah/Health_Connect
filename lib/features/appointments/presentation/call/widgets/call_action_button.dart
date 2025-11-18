// lib/features/call/presentation/widgets/call_action_button.dart
import 'package:flutter/material.dart';

class CallActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CallActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.iconColor = Colors.black,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          elevation: 2,
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: size * 0.45),
      ),
    );
  }
}
