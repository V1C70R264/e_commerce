import 'package:e_commerce/presentation/screens/home_screen.dart';
import 'package:e_commerce/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/authentication_field.dart';
import 'package:e_commerce/data/datasources/remote/localization_service.dart';
import 'package:e_commerce/data/datasources/remote/user_remote_datasource.dart';
import 'package:e_commerce/data/repositories/user_repository.dart' as data_repo;
import 'package:e_commerce/domain/usecases/user/login_user.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  var enteredEmail = '';
  var enteredPassword = '';
  bool isSending = false;

  ////////////LOGIN FUNCTIONALITY WITH DJANGO////////////////
  Future<void> loginUser() async {
    try {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;

      _formKey.currentState!.save();

      setState(() {
        isSending = true;
      });

      // Clean architecture: use case -> repository -> datasource
      final remote = UserRemoteDatasourceImpl();
      final repo = data_repo.UserRepositoryImpl(remote);
      final loginUser = LoginUser(repo);
      final success = await loginUser(
        email: enteredEmail.trim(),
        password: enteredPassword.trim(),
      );

      if (success) {
        // Navigate to home screen on success
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please check your credentials.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
  }
  /////////////////////////END OF LOGIC/////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.05),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // App Logo
                      Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        localizationService.getString('welcome_back'),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizationService.getString('sign_in_to_continue'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Username/Email Field
                      AuthenticationField(
                          label: localizationService
                              .getString('username_or_email'),
                          hint: localizationService
                              .getString('enter_username_or_email'),
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return localizationService
                                  .getString('please_enter_username');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredEmail = value!;
                          }),
                      const SizedBox(height: 20),
                      // Password Field
                      AuthenticationField(
                          label: localizationService.getString('password'),
                          hint: localizationService.getString('enter_password'),
                          prefixIcon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return localizationService
                                  .getString('please_enter_password');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredPassword = value!;
                          }),
                      const SizedBox(height: 12),
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            localizationService.getString('forgot_password'),
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isSending ? null : loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 0,
                          ),
                          child: isSending
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  localizationService.getString('login'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Sign Up Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizationService.getString('dont_have_account'),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            ),
                            child: Text(
                              localizationService.getString('sign_up'),
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Terms and Privacy with clickable links
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: localizationService
                                  .getString('terms_agreement'),
                            ),
                            TextSpan(
                              text: localizationService
                                  .getString('terms_of_service'),
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Terms of Service link tap
                                  // You can navigate to terms page or launch URL
                                },
                            ),
                            TextSpan(
                              text: localizationService.getString('and'),
                            ),
                            TextSpan(
                              text: localizationService
                                  .getString('privacy_policy'),
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Privacy Policy link tap
                                  // You can navigate to privacy page or launch URL
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
