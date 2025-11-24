import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_connect/features/doctor_appointments/models/appointment.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  DoctorAppointmentsCubit() : super(DoctorAppointmentsInitial());

  // In real app: replace with repository fetch
  Future<void> loadAppointments({String doctorId = ''}) async {
    emit(DoctorAppointmentsLoading());
    await Future.delayed(const Duration(milliseconds: 400)); // simulate IO

    // temporary sample data
    final now = DateTime.now();
    final sample = <Appointment>[
      Appointment(
          id: 'a1',
          patientId: 'p1',
          patientName: 'Ama Doe',
          startTime: now.add(const Duration(days: 1, hours: 2)),
          endTime: now.add(const Duration(days: 1, hours: 3)),
          reason: 'General check up',
          status: AppointmentStatus.upcoming),
      Appointment(
          id: 'a2',
          patientId: 'p2',
          patientName: 'Kwame Atta',
          startTime: now.subtract(const Duration(days: 2)),
          endTime: now.subtract(const Duration(days: 2)).add(const Duration(hours: 1)),
          reason: 'Follow-up',
          status: AppointmentStatus.past),
      Appointment(
          id: 'a3',
          patientId: 'p3',
          patientName: 'Esi Mensah',
          startTime: now.add(const Duration(days: 3)),
          endTime: now.add(const Duration(days: 3, hours: 1)),
          reason: 'Blood test review',
          status: AppointmentStatus.cancelled),
    ];

    emit(DoctorAppointmentsLoaded(appointments: sample));
  }

  // optional: start call — just emit event; actual call handled via route
  void startCall(Appointment a) {
    emit(DoctorCallStarted(appointment: a));
  }
}
