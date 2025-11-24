import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/features/appointments/presentation/call/bloc/call_cubit.dart';
import 'package:health_connect/features/appointments/presentation/call/bloc/call_state.dart';
import 'package:health_connect/features/appointments/presentation/call/widgets/call_action_button.dart';
import 'package:health_connect/features/appointments/presentation/call/widgets/small_preview_window.dart';
import 'package:health_connect/features/appointments/presentation/call/widgets/connection_status_banner.dart';

/// Arguments passed when navigating to /call
class CallScreenArgs {
  final bool isDoctor;
  final String doctorName;
  // extend with meeting id, participant details, etc.
  const CallScreenArgs({required this.isDoctor, required this.doctorName});
}

/// The call screen: doctor preview small, patient fullscreen
class OngoingCallScreen extends StatelessWidget {
  final CallScreenArgs args;
  const OngoingCallScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CallCubit(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                // connection banner
                BlocBuilder<CallCubit, CallState>(
                  builder: (context, state) {
                    return ConnectionStatusBanner(
                      message: state.connectionMessage,
                      isConnected: state.isConnected,
                    );
                  },
                ),

                // Expanded video area
                Expanded(
                  child: Stack(
                    children: [
                      // REMOTE VIDEO (for patient this is doctor - fullscreen)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: _RemoteVideoPlaceholder(
                              isDoctorView: args.isDoctor,
                              doctorName: args.doctorName,
                            ),
                          ),
                        ),
                      ),

                      // SMALL PREVIEW for doctor (small) or patient (small: shows doctor preview)
                      Positioned(
                        right: 16,
                        bottom: 140,
                        child: BlocBuilder<CallCubit, CallState>(
                          builder: (context, state) {
                            return SmallPreviewWindow(
                              isFrontCamera: state.isFrontCamera,
                              width: 130,
                              height: 180,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ACTIONS row
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute
                      BlocBuilder<CallCubit, CallState>(
                        builder: (context, state) {
                          return CallActionButton(
                            onPressed: () => context.read<CallCubit>().toggleMute(),
                            icon: state.isMuted ? Icons.mic_off : Icons.mic,
                            backgroundColor: state.isMuted ? Colors.grey[200]! : Colors.white,
                            iconColor: state.isMuted ? Colors.red : Colors.black,
                          );
                        },
                      ),

                      // Flip camera
                      CallActionButton(
                        onPressed: () => context.read<CallCubit>().flipCamera(),
                        icon: Icons.cameraswitch,
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                      ),

                      // End call (red)
                      CallActionButton(
                        onPressed: () {
                          context.read<CallCubit>().endCall();
                          // navigate back to schedule on end
                          context.go('/schedule');
                        },
                        icon: Icons.call_end,
                        backgroundColor: Colors.red,
                        iconColor: Colors.white,
                        size: 68,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: _buildDoctorRequestButton(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  /// Doctor-only "Request call" floating button when there's no active call.
  Widget _buildDoctorRequestButton(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      builder: (context, state) {
        if (!args.isDoctor) return const SizedBox.shrink();

        // doctor view: if not active -> show "Request Call" button.
        if (!state.isCallActive) {
          return FloatingActionButton.extended(
            onPressed: () => context.read<CallCubit>().requestCall(),
            label: const Text('Request Video Call'),
            icon: const Icon(Icons.video_call),
            backgroundColor: Colors.blueAccent,
          );
        }

        // doctor already in call -> no extra button
        return const SizedBox.shrink();
      },
    );
  }
}

/// small remote video placeholder (replace with actual renderer)
class _RemoteVideoPlaceholder extends StatelessWidget {
  final bool isDoctorView;
  final String doctorName;

  const _RemoteVideoPlaceholder({
    required this.isDoctorView,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    // If patient view: we show doctor's name big; if doctor view, we show the patient
    final label = isDoctorView ? 'Patient camera' : doctorName;
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam, size: 72, color: Colors.white24),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 6),
            const Text('Video feed (placeholder)', style: TextStyle(color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}
