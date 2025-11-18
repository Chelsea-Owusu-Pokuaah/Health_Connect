import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMine;
  final DateTime timestamp;
  final bool showTime;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMine,
    required this.timestamp,
    this.showTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // MESSAGE BUBBLE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: 6),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isMine ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message,
              style: AppTheme.bodyMedium.copyWith(
                color: isMine ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),

          // TIME BELOW (optional)
          if (showTime)
            Text(
              _formatTime(timestamp),
              style: AppTheme.captionStyle.copyWith(
                fontSize: 11,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
