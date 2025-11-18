// simple UI model used by the screen. Replace or map to your real model/BLoC model.
class Appointment {
  final String id;
  final String title;
  final DateTime dateTime;
  final String statusTag; // e.g. "SOON", "NEXT WEEK", "NEXT MONTH"
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorAvatarUrl; // network URL (nullable)
  final bool isVideoAvailable;

  Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.statusTag,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorAvatarUrl,
    this.isVideoAvailable = false,
  });
}
