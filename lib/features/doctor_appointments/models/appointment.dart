class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime startTime;
  final DateTime endTime;
  final String reason;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.status,
  });
}

enum AppointmentStatus { upcoming, past, cancelled }
