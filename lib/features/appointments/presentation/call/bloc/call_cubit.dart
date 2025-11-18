import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(const CallState());

  /// Doctor initiates a call request
  Future<void> requestCall() async {
    emit(state.copyWith(isCallActive: true, isConnected: false, connectionMessage: 'Requesting call...'));
    // Simulate signaling handshake / waiting for user to accept
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isConnected: true, connectionMessage: 'Connected'));
  }

  /// Patient accepts a call (if using signaling)
  Future<void> acceptCall() async {
    emit(state.copyWith(isCallActive: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isConnected: true, connectionMessage: 'Connected'));
  }

  /// Toggle mute
  void toggleMute() => emit(state.copyWith(isMuted: !state.isMuted));

  /// Flip camera
  void flipCamera() => emit(state.copyWith(isFrontCamera: !state.isFrontCamera));

  /// End call
  void endCall() => emit(const CallState()); // reset

  /// Simulate connection lost / update message
  void updateConnectionMessage(String message) =>
      emit(state.copyWith(connectionMessage: message, isConnected: false));
}
