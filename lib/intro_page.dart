import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'colors.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top section with logo and text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Logo
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'assets/logo.png', // Replace with your logo asset path
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16), // Space between logo and text
                // Text next to the logo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FarmMart',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    Text(
                      'Straight From Fields',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // PageView for sliding animation
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  'assets/intro_bg_1.png',
                  'Straight From Fields',
                  'FarmMart aims to eliminate middlemen, ensuring that farmers receive fair prices for their products while buyers get the best deals',
                ),
                _buildPage(
                  'assets/intro_bg_2.png',
                  'Fresh Produce',
                  'Get fresh produce directly from the farm, ensuring the best quality and taste.',
                ),
                _buildPage(
                  'assets/intro_bg_3.png',
                  'Fresh Produce',
                  'Get fresh produce directly from the farm, ensuring the best quality and taste.',
                ),
                // Add more pages as needed
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
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // handle skip
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: const Color.fromARGB(128, 128, 128, 128),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors
                          .midGreen, // Change this to your desired color
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
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
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkGreen,
                ),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(128, 128, 128, 128),
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
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
