// lib/features/call/presentation/widgets/small_preview_window.dart
import 'package:flutter/material.dart';

class SmallPreviewWindow extends StatelessWidget {
  final bool isFrontCamera;
  final double width;
  final double height;
  final Widget? child;

  const SmallPreviewWindow({
    super.key,
    required this.isFrontCamera,
    this.width = 120,
    this.height = 160,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
      ),
      child: child ??
          Center(
            child: Icon(
              isFrontCamera ? Icons.camera_front : Icons.camera_rear,
              color: Colors.white70,
              size: 36,
            ),
          ),
    );
  }
}
