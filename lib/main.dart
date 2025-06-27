import 'package:e_commerce/data/repositories/user_repository.dart';
import 'package:e_commerce/domain/repositories/user_repository.dart';
import 'package:e_commerce/domain/usecases/user/get_user_profile.dart';
import 'package:e_commerce/domain/usecases/user/update_user_profile_image.dart';
import 'package:e_commerce/presentation/screens/home_screen.dart';
import 'package:e_commerce/presentation/screens/login_screen.dart';
import 'package:e_commerce/presentation/screens/modern_onboarding_screen.dart';
import 'package:e_commerce/presentation/screens/onboarding_screen.dart';
import 'package:e_commerce/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/data/datasources/remote/user_remote_datasource.dart';
import 'package:e_commerce/presentation/screens/language_selection_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubit/profile_cubit.dart';

void main() {
  print('APP STARTED!!!');
  WidgetsFlutterBinding.ensureInitialized();
  final userRemoteDatasource = UserRemoteDatasourceImpl();
  final userRepository = UserRepositoryImpl(userRemoteDatasource);
  final getUserProfile = GetUserProfile(userRepository);
  final updateUserProfileImage = UpdateUserProfileImage(userRepository);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ProfileCubit(getUserProfile, updateUserProfileImage),
      ),
    ],
    child: const MyApp(),
  ));
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
              future: UserRemoteDatasourceImpl().isLoggedIn(),
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
