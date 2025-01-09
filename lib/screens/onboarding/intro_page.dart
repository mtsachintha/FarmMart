import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../colors.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _navigateToMainScreen();
    }
  }

  void _navigateToMainScreen() {
    // Replace this with the actual navigation logic
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set a white background
      body: SafeArea(
        child: Column(
          children: [
            // Top section with logo and text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft, // Aligns the logo to the left
                child: Image.asset(
                  'assets/logo_banner_black.png',
                  height: 50,
                ),
              ),
            ),
            // PageView for sliding animation
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage('assets/intro_bg_1.png', 'Straight From Fields',
                      "FarmMart connects farmers directly with buyers, ensuring fair prices for farmers and great deals for buyers."),
                  _buildPage(
                    'assets/intro_bg_2.png',
                    'Fresh Produce',
                    'Get fresh produce directly from the farm, ensuring the best quality and taste.',
                  ),
                  _buildPage(
                    'assets/intro_bg_3.png',
                    'Track and Manage',
                    'Seamlessly manage your orders and shipments in one place.',
                  ),
                ],
              ),
            ),
            // Carousel indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 3,
                effect: WormEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  activeDotColor: AppColors.darkGreen,
                  dotColor: Colors.grey,
                ), // your preferred effect
              ),
            ),
            // Buttons on top of the image
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      onPressed: _navigateToMainScreen,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: const Color.fromARGB(128, 128, 128, 128),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  // Next or Get Started button
                  SizedBox(
                    width: 240,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                      ),
                      child: Text(
                        _currentPage == 2 ? 'Get Started' : 'Next',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String description) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth, // Ensures the image fits the width
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
