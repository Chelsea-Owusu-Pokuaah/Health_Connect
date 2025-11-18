/// Represents any user participating in a chat conversation.
/// Works for both patient-side and doctor-side apps.
class ChatParticipant {
  final String id;
  final String name;
  final String role; // 'doctor' or 'patient'
  final String? avatarUrl;
  final bool isOnline;

  ChatParticipant({
    required this.id,
    required this.name,
    required this.role,
    this.avatarUrl,
    this.isOnline = false,
  });
}
