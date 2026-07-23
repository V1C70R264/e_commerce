import 'package:e_commerce/core/utils/result.dart';
import 'package:e_commerce/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/presentation/screens/verify_otp_screen.dart';
import 'package:e_commerce/presentation/widgets/auth_custom_widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForgotPassword() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final forgotPasswordUseCase = ForgotPasswordUseCase(appAuthRepository);
      final result = await forgotPasswordUseCase(email);

      if (!mounted) return;

      if (result is Success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent to your email address'),
            backgroundColor: Color(0xFF22A45D),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerifyOtpScreen(email: email),
          ),
        );
      } else if (result is Error) {
        // Fallback for user ease of navigation even if backend email fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.redAccent,
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerifyOtpScreen(email: email),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: 'Forgot Password',
                  subtitle:
                      'Enter your email address to receive a reset link and regain access to your account.',
                ),
                const SizedBox(height: 36),
                AuthInputField(
                  controller: _emailController,
                  hintText: 'Email address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                PrimaryPillButton(
                  text: 'Continue',
                  isLoading: _isLoading,
                  onPressed: _submitForgotPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
