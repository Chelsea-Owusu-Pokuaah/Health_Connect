import 'package:flutter/material.dart';

class ActionCircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const ActionCircleButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
        ),
        child: Center(child: child),
      ),
    );
  }
}
