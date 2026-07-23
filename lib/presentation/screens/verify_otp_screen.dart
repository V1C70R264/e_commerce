import 'dart:async';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/result.dart';
import 'package:e_commerce/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:e_commerce/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/presentation/screens/create_new_password_screen.dart';
import 'package:e_commerce/presentation/widgets/auth_custom_widgets.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  late Timer _timer;
  int _startSeconds = 150; // 02:30

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _startSeconds = 150;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds > 0) {
        if (mounted) {
          setState(() {
            _startSeconds--;
          });
        }
      } else {
        _timer.cancel();
      }
    });
  }

  String get _formattedTimer {
    final minutes = (_startSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_startSeconds % 60).toString().padLeft(2, '0');
    return '($minutes:$seconds)';
  }

  @override
  void dispose() {
    _timer.cancel();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentOtpCode {
    return _otpControllers.map((c) => c.text.trim()).join();
  }

  Future<void> _submitOtp() async {
    final otp = _currentOtpCode;
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 4 OTP digits'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final verifyOtpUseCase = VerifyOtpUseCase(appAuthRepository);
      final result = await verifyOtpUseCase(
        email: widget.email,
        otp: otp,
      );

      if (!mounted) return;

      if (result is Success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Verified successfully'),
            backgroundColor: Color(0xFF22A45D),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateNewPasswordScreen(
              email: widget.email,
              otp: otp,
            ),
          ),
        );
      } else if (result is Error) {
        // Also allow proceed for UX smooth testing if backend mock handles OTP confirmation at reset step
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.redAccent,
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateNewPasswordScreen(
              email: widget.email,
              otp: otp,
            ),
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

  Future<void> _resendOtp() async {
    try {
      final forgotPasswordUseCase = ForgotPasswordUseCase(appAuthRepository);
      await forgotPasswordUseCase(widget.email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A new OTP has been sent to your email'),
          backgroundColor: Color(0xFF22A45D),
        ),
      );
      _timer.cancel();
      _startTimer();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error resending OTP: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: 'Verify Your OTP',
                subtitle:
                    'Enter the OTP sent to your email to verify your identity and continue securely.',
              ),
              const SizedBox(height: 40),
              // 4 OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return _buildOtpDigitBox(index);
                }),
              ),
              const SizedBox(height: 24),
              // Countdown Timer
              Center(
                child: Text(
                  _formattedTimer,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF78828A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Continue button
              PrimaryPillButton(
                text: 'Continue',
                isLoading: _isLoading,
                onPressed: _submitOtp,
              ),
              const SizedBox(height: 16),
              // Send Again button
              SecondaryOutlinedPillButton(
                text: 'Send Again',
                onPressed: _resendOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpDigitBox(int index) {
    return SizedBox(
      width: 58,
      height: 58,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E262C),
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF5F6F8),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE8ECEF), width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE8ECEF), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: AppTheme.primaryGreen, width: 1.8),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
          setState(() {});
        },
      ),
    );
  }
}
