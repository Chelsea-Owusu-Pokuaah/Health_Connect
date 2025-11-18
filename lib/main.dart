import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthConnectApp());
}

class HealthConnectApp extends StatelessWidget {
  const HealthConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HealthConnect',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
