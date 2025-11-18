import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/features/onboarding/presentation/widgets/app_logo_widget.dart';
import 'package:health_connect/features/onboarding/presentation/widgets/primary_button.dart';
import 'package:health_connect/shared/widgets/app_text_field.dart';
import 'package:health_connect/core/themes/app_theme.dart';
import 'package:health_connect/core/themes/app_colors.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _loading = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
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

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm password';
    if (v != _passwordCtrl.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _onContinue() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800)); // mock API
    setState(() => _loading = false);

    // After signup → navigate to login
    context.go('/login');
  }

  void _onLogin() => context.go('/login');

  @override
  Widget build(BuildContext context) {
    const double horizontal = 24.0;

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

                const Center(child: AppLogoWidget()),

                const SizedBox(height: 64),

                Text(
                  'Sign Up',
                  style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 28),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Phone',
                        controller: _phoneCtrl,
                        hintText: 'Phone',
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),

                      const SizedBox(height: 16),

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
                  text: _loading ? 'Please wait…' : 'Continue',
                  filled: true,
                  enabled: !_loading,
                  onTap: _onContinue,
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
