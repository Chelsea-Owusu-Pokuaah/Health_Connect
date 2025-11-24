import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Splash
import 'package:health_connect/features/splash/presentation/splash_screen.dart';

// Onboarding
import 'package:health_connect/features/onboarding/presentation/onboarding_screen.dart';

// Authentication
import 'package:health_connect/features/authentication/presentation/login_screen.dart';
import 'package:health_connect/features/authentication/presentation/signup_screen.dart';

// Home
import 'package:health_connect/features/home/presentation/home_screen.dart';

// Appointments
import 'package:health_connect/features/appointments/presentation/schedule_appointment.dart';
import 'package:health_connect/features/appointments/presentation/book_appointment/book_appointment_screen.dart';
import 'package:health_connect/features/appointments/presentation/call/presentation/ongoing_screen_call.dart';

// Doctor appointments
import 'package:health_connect/features/doctor_appointments/bloc/doctor_appointments_cubit.dart';
import 'package:health_connect/features/doctor_appointments/models/appointment.dart';
import 'package:health_connect/features/doctor_appointments/presentation/doctor_appointments_screen.dart';
import 'package:health_connect/features/doctor_appointments/presentation/appointment_detail_screen.dart';


// Chat
import 'package:health_connect/features/chat/presentation/chat_detail_screen.dart';
import 'package:health_connect/features/chat/presentation/chat_list_screen.dart';
import 'package:health_connect/features/chat/presentation/models/chat_participant.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [

    /// --------------------
    /// CORE FLOWS
    /// --------------------
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (_, __) => const SignupScreen(),
    ),

    /// --------------------
    /// HOME
    /// --------------------
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),

    /// --------------------
    /// FEATURE TILE ROUTES
    /// --------------------
    GoRoute(
      path: '/my_doctors',
      builder: (_, __) => const PlaceholderScreen(title: 'My Doctors'),
    ),
    GoRoute(
      path: '/prescriptions',
      builder: (_, __) => const PlaceholderScreen(title: 'Prescriptions'),
    ),
    GoRoute(
      path: '/lab_results',
      builder: (_, __) => const PlaceholderScreen(title: 'Lab Results'),
    ),
    GoRoute(
      path: '/medications',
      builder: (_, __) => const PlaceholderScreen(title: 'Medications'),
    ),

    /// Appointments
    GoRoute(
      path: '/schedule',
      builder: (_, __) => const ScheduleAppointmentScreen(),
    ),

    /// --------------------
    /// BOTTOM NAV ROUTES
    /// --------------------

    /// Replace placeholder with REAL chat list
    GoRoute(
      path: '/messages',
      builder: (_, __) => const ChatListScreen(),
    ),

    GoRoute(
      path: '/create_appointment',
      builder: (_, __) => const BookAppointmentScreen(),
    ),

    GoRoute(
      path: '/settings',
      builder: (_, __) => const PlaceholderScreen(title: 'Settings'),
    ),

    /// Notifications
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const PlaceholderScreen(title: 'Notifications'),
    ),

    /// --------------------
    /// CHAT ROUTES
    /// --------------------

    // Direct Chat list route (if needed manually)
    GoRoute(
      path: '/chat_list',
      name: 'chat_list',
      builder: (context, state) => const ChatListScreen(),
    ),

    // Chat detail route with participant passed via state.extra
    GoRoute(
      path: '/chat_detail',
      name: 'chat_detail',
      builder: (context, state) {
        final participant = state.extra as ChatParticipant;
        return ChatDetailScreen(participant: participant);
      },
    ),

    // Doctor appointments dashboard
    GoRoute(
      path: '/doctor/appointments',
      name: 'doctor_appointments',
      builder: (context, state) => BlocProvider(
        create: (_) => DoctorAppointmentsCubit()..loadAppointments(),
        child: const DoctorAppointmentsScreen(),
      ),
    ),

    GoRoute(
      path: '/doctor/appointment/:id',
      name: 'doctor_appointment_detail',
      builder: (context, state) {
        final appointment = state.extra;
        if (appointment is Appointment) {
          return AppointmentDetailScreen(appointment: appointment);
        }
        return const PlaceholderScreen(title: 'Appointment not found');
      },
    ),

    GoRoute(
      path: '/call',
      name: 'call',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is CallScreenArgs) {
          return OngoingCallScreen(args: extra);
        }
        if (extra is Appointment) {
          return OngoingCallScreen(
            args: CallScreenArgs(
              isDoctor: true,
              doctorName: extra.patientName,
            ),
          );
        }
        return const OngoingCallScreen(
          args: CallScreenArgs(isDoctor: false, doctorName: 'Doctor'),
        );
      },
    ),
  ],
);

/// ------------------------------------------------------------
/// TEMP SCREENS
/// ------------------------------------------------------------
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title Screen',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
