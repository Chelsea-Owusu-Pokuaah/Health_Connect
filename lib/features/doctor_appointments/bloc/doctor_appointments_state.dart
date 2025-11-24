part of 'doctor_appointments_cubit.dart';

abstract class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();

  @override
  List<Object?> get props => [];
}

class DoctorAppointmentsInitial extends DoctorAppointmentsState {}
class DoctorAppointmentsLoading extends DoctorAppointmentsState {}
class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final List<Appointment> appointments;
  const DoctorAppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}
class DoctorAppointmentsError extends DoctorAppointmentsState {
  final String message;
  const DoctorAppointmentsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorCallStarted extends DoctorAppointmentsState {
  final Appointment appointment;
  const DoctorCallStarted({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}
