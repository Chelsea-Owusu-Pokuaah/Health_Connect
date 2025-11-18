// lib/features/call/presentation/cubit/call_state.dart
import 'package:equatable/equatable.dart';

class CallState extends Equatable {
  final bool isCallActive;
  final bool isMuted;
  final bool isFrontCamera;
  final bool isConnected;
  final String connectionMessage;

  const CallState({
    this.isCallActive = false,
    this.isMuted = false,
    this.isFrontCamera = true,
    this.isConnected = false,
    this.connectionMessage = 'Connecting...',
  });

  CallState copyWith({
    bool? isCallActive,
    bool? isMuted,
    bool? isFrontCamera,
    bool? isConnected,
    String? connectionMessage,
  }) {
    return CallState(
      isCallActive: isCallActive ?? this.isCallActive,
      isMuted: isMuted ?? this.isMuted,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      isConnected: isConnected ?? this.isConnected,
      connectionMessage: connectionMessage ?? this.connectionMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isCallActive, isMuted, isFrontCamera, isConnected, connectionMessage];
}
