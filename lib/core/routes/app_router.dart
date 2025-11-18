import 'package:flutter/material.dart';
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
