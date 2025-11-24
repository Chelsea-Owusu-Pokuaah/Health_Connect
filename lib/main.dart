
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Import flutter_bloc

// 2. Import your Auth logic and Service
import 'features/authentication/bloc/auth/auth_cubit.dart';
import 'features/authentication/data/services/auth_service.dart'; 

import 'firebase_options.dart';      
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HealthConnectApp());
}

class HealthConnectApp extends StatelessWidget {
  const HealthConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Wrap MaterialApp.router with MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        // 4. Inject AuthCubit here so the whole app can use it
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthService()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HealthConnect',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}