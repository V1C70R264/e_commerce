import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingItem> get _items => [
    OnboardingItem(
      title: localizationService.getString('welcome_to_freshcart'),
      description: localizationService.getString('discover_amazing_products'),
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingItem(
      title: localizationService.getString('fast_delivery'),
      description: localizationService.getString('get_orders_delivered'),
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingItem(
      title: localizationService.getString('secure_payments'),
      description: localizationService.getString('shop_safely'),
      image: 'assets/images/onboarding3.png',
    ),
  ];

  late AnimationController _animationController;
  late Animation<double> _imageAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _descriptionAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Staggered fade animations
    _imageAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    _descriptionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), _nextPage);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      // Reset and start animation for next page
      _animationController.reset();
      _animationController.forward();

      Future.delayed(const Duration(seconds: 3), _nextPage);
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return _buildPage(_items[index], isLandscape, screenHeight);
                },
              ),
            ),
            // Bottom navigation section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical:
                    isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Worm effect indicator
                  SizedBox(
                    height: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _items.length,
                        (index) => _buildWormIndicator(index),
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 16 : 32),
                  // Show different buttons based on current page
                  if (_currentPage == _items.length - 1)
                    // Get Started button for last page
                    SizedBox(
                      width: double.infinity,
                      height: isLandscape ? 48 : 56,
                      child: ElevatedButton(
                        onPressed: _navigateToLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          localizationService.getString('get_started'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    // Skip and Next row for other pages
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _navigateToLogin,
                          child: Text(
                            localizationService.getString('skip'),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _nextPage,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
      OnboardingItem item, bool isLandscape, double screenHeight) {
    return SingleChildScrollView(
      child: Container(
        height: screenHeight -
            (isLandscape ? 100 : 150), // Adjust for bottom navigation
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: isLandscape ? 16 : 24,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1), // Adds flexible space at the top
              // Animated Image
              FadeTransition(
                opacity: _imageAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Image.asset(
                    item.image,
                    height:
                        isLandscape ? screenHeight * 0.4 : screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: isLandscape ? 20 : 40),
              // Animated Title
              FadeTransition(
                opacity: _titleAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Animated Description
              FadeTransition(
                opacity: _descriptionAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1), // Adds flexible space at the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWormIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _currentPage == index ? Colors.green : Colors.grey[300],
      ),
    );
  }

  // Add this new method for page change animation
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // Reset and start animation for the new page
    _animationController.reset();
    _animationController.forward();
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}
