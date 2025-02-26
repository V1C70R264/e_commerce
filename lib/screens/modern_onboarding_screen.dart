import 'package:flutter/material.dart';

class ModernOnboardingScreen extends StatefulWidget {
  const ModernOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<ModernOnboardingScreen> createState() => _ModernOnboardingScreenState();
}

class _ModernOnboardingScreenState extends State<ModernOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Welcome to FreshCart',
      description: "It's the simplest and safest way to invest, store and send crypto money.",
      image: 'assets/images/onboarding2.png',
      backgroundImages: [
        BackgroundImage(top: 50, left: 20, image: 'assets/images/profile1.png'),
        BackgroundImage(top: 120, right: 30, image: 'assets/images/profile2.png'),
        BackgroundImage(top: 200, left: 40, image: 'assets/images/profile3.png'),
      ],
    ),
    OnboardingItem(
      title: 'Future of money',
      description: "It gets better every day. More users and better value every day. eGold is here to change that.",
      image: 'assets/images/onboarding1.png',
      backgroundImages: [
        BackgroundImage(top: 80, right: 40, image: 'assets/images/profile4.png'),
        BackgroundImage(top: 180, left: 30, image: 'assets/images/profile5.png'),
      ],
    ),
    OnboardingItem(
      title: 'Future of money',
      description: "It gets better every day. More users and better value every day. eGold is here to change that.",
      image: 'assets/images/onboarding3.png',
      backgroundImages: [
        BackgroundImage(top: 80, right: 40, image: 'assets/images/profile4.png'),
        BackgroundImage(top: 180, left: 30, image: 'assets/images/profile5.png'),
      ],
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(_items[index]);
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Worm Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _items.length,
                    (index) => _buildWormIndicator(index),
                  ),
                ),
                const SizedBox(height: 20),
                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _items.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to home screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _items.length - 1 ? 'Get Started' : 'Continue',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Stack(
      children: [
        // Background floating images
        ...item.backgroundImages.map((bgImage) => Positioned(
          top: bgImage.top,
          left: bgImage.left,
          right: bgImage.right,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(bgImage.image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        )),
        // Content
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(item.image),
              ),
              const SizedBox(height: 40),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
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
        color: _currentPage == index ? Colors.blue[700] : Colors.grey[300],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final List<BackgroundImage> backgroundImages;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundImages,
  });
}

class BackgroundImage {
  final double top;
  final double? left;
  final double? right;
  final String image;

  BackgroundImage({
    required this.top,
    this.left,
    this.right,
    required this.image,
  });
}