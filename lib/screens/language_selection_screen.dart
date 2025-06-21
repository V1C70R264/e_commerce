import 'package:flutter/material.dart';
import 'package:e_commerce/screens/onboarding_screen.dart';
import 'package:e_commerce/services/localization_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _buttonsAnimation;
  late Animation<Offset> _slideAnimation;

  String? selectedLanguage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Staggered animations
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    ));

    _subtitleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    ));

    _buttonsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectLanguage(String language) async {
    setState(() {
      selectedLanguage = language;
    });

    // Determine language code
    String languageCode = 'en';
    if (language == 'Kiswahili') {
      languageCode = 'sw';
    }

    // Save language preference and update localization service
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
    await localizationService.changeLocale(languageCode);

    // Navigate to onboarding screen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient circles (matching onboarding style)
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
              child: Container(
                height: screenHeight - (isLandscape ? 80 : 100),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    
                    // Animated Logo
                    FadeTransition(
                      opacity: _logoAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: isLandscape ? screenHeight * 0.25 : screenHeight * 0.2,
                          width: isLandscape ? screenHeight * 0.25 : screenHeight * 0.2,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: isLandscape ? 24 : 40),
                    
                    // Animated Title
                    FadeTransition(
                      opacity: _titleAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Text(
                          localizationService.getString('choose_language'),
                          style: TextStyle(
                            fontSize: isLandscape ? 20 : 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: isLandscape ? 8 : 12),
                    
                    // Animated Subtitle
                    FadeTransition(
                      opacity: _subtitleAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Text(
                          localizationService.getString('chagua_lugha'),
                          style: TextStyle(
                            fontSize: isLandscape ? 16 : 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: isLandscape ? 32 : 48),
                    
                    // Language Selection Buttons
                    FadeTransition(
                      opacity: _buttonsAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            // English Button
                            _buildLanguageButton(
                              language: 'English',
                              flag: '🇺🇸',
                              isSelected: selectedLanguage == 'English',
                              onTap: () => _selectLanguage('English'),
                              isLandscape: isLandscape,
                              screenHeight: screenHeight,
                            ),
                            
                            SizedBox(height: isLandscape ? 16 : 20),
                            
                            // Kiswahili Button
                            _buildLanguageButton(
                              language: 'Kiswahili',
                              flag: '🇹🇿',
                              isSelected: selectedLanguage == 'Kiswahili',
                              onTap: () => _selectLanguage('Kiswahili'),
                              isLandscape: isLandscape,
                              screenHeight: screenHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton({
    required String language,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isLandscape,
    required double screenHeight,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: isLandscape ? 60 : 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flag,
              style: TextStyle(
                fontSize: isLandscape ? 24 : 28,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              language,
              style: TextStyle(
                fontSize: isLandscape ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 16),
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
} 