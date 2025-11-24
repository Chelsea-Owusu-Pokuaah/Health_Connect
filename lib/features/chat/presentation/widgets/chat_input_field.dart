import 'package:flutter/material.dart';
import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

class ChatInputField extends StatefulWidget {
  final VoidCallback onSendText;
  final VoidCallback onRecordVoice;
  final TextEditingController controller;

  const ChatInputField({
    super.key,
    required this.onSendText,
    required this.onRecordVoice,
    required this.controller,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool _isRecording = false;

  void _toggleRecord() {
    setState(() => _isRecording = !_isRecording);
    widget.onRecordVoice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // VOICE RECORD BUTTON
          GestureDetector(
            onTap: _toggleRecord,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _isRecording
                    ? Colors.red
                    : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: _isRecording ? Colors.white : AppColors.primary,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // TEXT FIELD
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: AppTheme.captionStyle,
                border: InputBorder.none,
              ),
              style: AppTheme.bodyMedium,
              minLines: 1,
              maxLines: 5,
            ),
          ),

          const SizedBox(width: 8),

          // SEND BUTTON
          GestureDetector(
            onTap: widget.onSendText,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
