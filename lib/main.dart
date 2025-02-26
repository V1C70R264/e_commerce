// import 'package:e_commerce/screens/cart_screen.dart';
// import 'package:e_commerce/screens/email_screen.dart';
// import 'package:e_commerce/screens/email_verification_screen.dart';
// import 'package:e_commerce/screens/favorites_screen.dart';
// import 'package:e_commerce/screens/orders_screen.dart';
// import 'package:e_commerce/screens/phone_number_verification.dart';
// import 'package:e_commerce/screens/phone_verification_screen.dart';
// import 'package:e_commerce/screens/product_detail_screen.dart';
// import 'package:e_commerce/screens/profile_screen.dart';
// import 'package:e_commerce/screens/auth/login_screen.dart';
// import 'package:e_commerce/screens/splash_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/modern_onboarding_screen.dart';
import 'package:e_commerce/screens/onboarding_screen.dart';
import 'package:e_commerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: const OnboardingScreen(),
    );
  }
}
