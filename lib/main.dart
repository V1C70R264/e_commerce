import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/modern_onboarding_screen.dart';
import 'package:e_commerce/screens/onboarding_screen.dart';
import 'package:e_commerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/services/django_auth_service.dart';
import 'package:e_commerce/screens/language_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soko Mkononi',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            final prefs = snapshot.data!;
            final selectedLanguage = prefs.getString('selected_language');
            if (selectedLanguage == null) {
              return const LanguageSelectionScreen();
            }
            return FutureBuilder<bool>(
              future: DjangoAuthService.isLoggedIn(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (authSnapshot.hasData && authSnapshot.data == true) {
                  return const HomeScreen();
                }
                // Show onboarding, then login
                return const OnboardingScreen();
              },
            );
          }
          return const SplashScreen();
        },
      ),
    );
  }
}