import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_connect/core/themes/app_colors.dart';
import 'package:health_connect/core/themes/app_theme.dart';

import 'package:health_connect/features/onboarding/presentation/widgets/app_logo_widget.dart';
import 'package:health_connect/features/onboarding/presentation/widgets/primary_button.dart';
import 'package:health_connect/shared/widgets/app_text_field.dart';

import '../bloc/auth/auth_cubit.dart';
import '../bloc/auth/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;

  String _role = "patient"; // default selection

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validateFullName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your full name';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your email';
    if (!v.contains('@')) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Enter password';
    if (v.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Confirm password';
    if (v != _passwordCtrl.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _onContinue() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    await context.read<AuthCubit>().signUp(
      fullName: _fullNameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
      role: _role,
    );
  }



  void _onLogin() => context.go('/login');

  @override
  Widget build(BuildContext context) {
    const double horizontal = 24.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go('/home');
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final loading = state is AuthLoading;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Center(child: AppLogoWidget()),
                    const SizedBox(height: 64),

                    Text(
                      'Sign Up',
                      style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// ------------------------
                    /// FORM
                    /// ------------------------
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            label: 'Full Name',
                            controller: _fullNameCtrl,
                            hintText: 'Full Name',
                            validator: _validateFullName,
                          ),

                          const SizedBox(height: 16),

                          AppTextField(
                            label: 'Email',
                            controller: _emailCtrl,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),

                          const SizedBox(height: 16),

                          /// ------------------------
                          /// ROLE SELECTION
                          /// ------------------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I am a:",
                                style: AppTheme.titleStyle.copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _RoleOption(
                                    label: "Patient",
                                    selected: _role == "patient",
                                    onTap: () => setState(() => _role = "patient"),
                                  ),
                                  const SizedBox(width: 12),
                                  _RoleOption(
                                    label: "Doctor",
                                    selected: _role == "doctor",
                                    onTap: () => setState(() => _role = "doctor"),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          AppTextField(
                            label: 'Password',
                            controller: _passwordCtrl,
                            obscureText: _obscure1,
                            hintText: 'Password',
                            validator: _validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure1 ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () => setState(() => _obscure1 = !_obscure1),
                            ),
                          ),

                          const SizedBox(height: 16),

                          AppTextField(
                            label: 'Confirm Password',
                            controller: _confirmCtrl,
                            obscureText: _obscure2,
                            hintText: 'Confirm Password',
                            validator: _validateConfirm,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure2 ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () => setState(() => _obscure2 = !_obscure2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: GestureDetector(
                        onTap: _onLogin,
                        child: RichText(
                          text: TextSpan(
                            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Login',
                                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    PrimaryButton(
                      text: loading ? 'Please wait…' : 'Continue',
                      filled: true,
                      enabled: !loading,
                      onTap: _onContinue,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ------------------------------------------------
/// Role selection button widget
/// ------------------------------------------------
class _RoleOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RoleOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 1.4,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
