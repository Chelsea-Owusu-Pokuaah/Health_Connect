import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class ChatMessageBubble extends StatelessWidget {
  final String? text;
  final String? imageUrl;
  final String? audioUrl; // placeholder for voice messages
  final bool isMe;
  final DateTime timestamp;

  const ChatMessageBubble({
    super.key,
    this.text,
    this.imageUrl,
    this.audioUrl,
    required this.isMe,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? AppColors.primary : AppColors.surface;
    final textColor = isMe ? Colors.white : AppColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // MAIN BUBBLE
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: EdgeInsets.all(imageUrl != null || audioUrl != null ? 10 : 14),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 0),
                  bottomRight: Radius.circular(isMe ? 0 : 18),
                ),
              ),
              child: _buildContent(textColor),
            ),

            const SizedBox(height: 4),

            // TIMESTAMP
            Text(
              _formatTimestamp(timestamp),
              style: AppTheme.captionStyle.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    // IMAGE MESSAGE
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl!,
          width: 220,
          fit: BoxFit.cover,
        ),
      );
    }

    // VOICE NOTE (placeholder UI)
    if (audioUrl != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, color: textColor),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: textColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "0:15",
            style: TextStyle(color: textColor, fontSize: 12),
          )
        ],
      );
    }

    // TEXT MESSAGE
    return Text(
      text ?? "",
      style: AppTheme.bodyMedium.copyWith(color: textColor, height: 1.4),
    );
  }

  String _formatTimestamp(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = time.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $suffix";
  }
}
