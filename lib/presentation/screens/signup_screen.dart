import 'package:e_commerce/presentation/widgets/authentication_field.dart';
import 'package:e_commerce/data/datasources/remote/user_remote_datasource.dart';
import 'package:e_commerce/data/repositories/user_repository.dart' as data_repo;
import 'package:e_commerce/domain/usecases/user/register_user.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _acceptedTerms = false;
  var enteredEmail = '';
  var enteredPassword = '';
  var enterdPhoneNumber = '';
  var enteredUsername = '';
  var enteredFirstName = '';
  var enteredLastName = '';
  bool isSending = false;

  ///////////////////CREATING ACCOUNT LOGIC WITH DJANGO/////////////////////
  void createAccount() async {
    try {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }

      if (!_acceptedTerms) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the Terms of Service'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _formKey.currentState!.save();

      setState(() {
        isSending = true;
      });

      // Clean architecture: use case -> repository -> datasource
      final remote = UserRemoteDatasourceImpl();
      final repo = data_repo.UserRepositoryImpl(remote);
      final registerUser = RegisterUser(repo);
      final success = await registerUser(
        username: enteredUsername.trim(),
        email: enteredEmail.trim(),
        password: enteredPassword.trim(),
        firstName: enteredFirstName.trim(),
        lastName: enteredLastName.trim(),
      );

      if (success) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully! Please login.'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate back to login screen
          Navigator.pop(context);
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Please try again.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in your details to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Username Field
                      AuthenticationField(
                        label: 'Username',
                        hint: 'Choose a username',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredUsername = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      // First Name Field
                      AuthenticationField(
                        label: 'First Name',
                        hint: 'Enter your first name',
                        prefixIcon: Icons.badge_outlined,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredFirstName = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Last Name Field
                      AuthenticationField(
                        label: 'Last Name',
                        hint: 'Enter your last name',
                        prefixIcon: Icons.badge_outlined,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredLastName = value!;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Email Field
                      AuthenticationField(
                        label: 'Email',
                        hint: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredEmail = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Phone Number Field
                      AuthenticationField(
                        label: 'Phone Number (Optional)',
                        hint: 'Enter your phone number',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          enterdPhoneNumber = value!;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      AuthenticationField(
                        label: 'Password',
                        hint: 'Create a password',
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
                            return 'Please enter a password';
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          enteredPassword = value!;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 24),

                      // Terms and Conditions Checkbox
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _acceptedTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptedTerms = value ?? false;
                                });
                              },
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'I agree to the Terms of Service and Privacy Policy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (_acceptedTerms && !isSending)
                              ? createAccount
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
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
                              : const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }

  // Widget _buildTextField({
  //   required String label,
  //   required String hint,
  //   required IconData prefixIcon,
  //   TextInputType? keyboardType,
  //   bool obscureText = false,
  //   Widget? suffixIcon,
  //   String? Function(String?)? validator,
  // }) {
  // return Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       label,
  //       style: const TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //     const SizedBox(height: 8),
  //     TextFormField(
  //       decoration: InputDecoration(
  //         hintText: hint,
  //         hintStyle: TextStyle(
  //           color: Colors.grey[400],
  //           fontSize: 14,
  //         ),
  //         prefixIcon: Icon(prefixIcon, color: Colors.grey[400], size: 22),
  //         suffixIcon: suffixIcon,
  //         filled: true,
  //         fillColor: Colors.grey[50],
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide.none,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: Colors.grey[200]!),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: const BorderSide(color: Colors.green),
  //         ),
  //         errorBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: const BorderSide(color: Colors.red),
  //         ),
  //       ),
  //       keyboardType: keyboardType,
  //       obscureText: obscureText,
  //       validator: validator,
  //       style: const TextStyle(fontSize: 14),
  //     ),
  //   ],
  // );
}
