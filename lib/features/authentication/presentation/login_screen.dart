import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:health_connect/features/onboarding/presentation/widgets/app_logo_widget.dart';
import 'package:health_connect/features/onboarding/presentation/widgets/primary_button.dart';
import 'package:health_connect/shared/widgets/app_text_field.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter phone number';
    final clean = v.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^\d+$').hasMatch(clean)) return 'Phone must contain digits only';
    if (clean.length < 9) return 'Enter a valid phone number';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter password';
    if (v.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  Future<void> _onContinue() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    // TODO: Replace with your Auth BLoC / repository call.
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() => _loading = false);

    // On successful login navigate to home screen
    context.go('/home');
  }

  void _onSignUp() => context.go('/signup');

  @override
  Widget build(BuildContext context) {
    final horizontal = 24.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                // App logo (reused from onboarding)
                const Center(child: AppLogoWidget()),

                const SizedBox(height: 64),

                // Header
                Text('Login',
                    style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    )),

                const SizedBox(height: 28),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Phone',
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                        hintText: 'Phone',
                      ),

                      const SizedBox(height: 16),

                      AppTextField(
                        label: 'Password',
                        controller: _passwordCtrl,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscure,
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.textSecondary),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        validator: _validatePassword,
                        hintText: 'Password',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sign up link
                Center(
                  child: GestureDetector(
                    onTap: _onSignUp,
                    child: RichText(
                      text: TextSpan(
                        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Sign Up',
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

                // Continue button (modified PrimaryButton with filled=true)
                PrimaryButton(
                  text: _loading ? 'Please wait…' : 'Continue',
                  onTap: _onContinue,
                  filled: true,
                  enabled: !_loading,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
