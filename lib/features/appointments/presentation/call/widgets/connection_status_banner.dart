// lib/features/call/presentation/widgets/connection_status_banner.dart
import 'package:flutter/material.dart';

class ConnectionStatusBanner extends StatelessWidget {
  final String message;
  final bool isConnected;

  const ConnectionStatusBanner({
    super.key,
    required this.message,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: isConnected ? Colors.green.withOpacity(0.14) : Colors.orange.withOpacity(0.12),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isConnected ? Colors.green[800] : Colors.orange[900],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
