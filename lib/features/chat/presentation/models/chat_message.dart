enum ChatMessageType { text, voice }

class ChatMessage {
  final String id;
  final String senderId; // "doctor" or "patient"
  final String content;  // text OR local path for voice recording
  final ChatMessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
  });
}
