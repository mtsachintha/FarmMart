import 'package:flutter/material.dart';
import 'colors.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle back button press
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: Image.asset(
                      'assets/logo.png', // Replace with your logo asset path
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 24), // Space between logo and text
                  // Text next to the logo
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FarmMart',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      Text(
                        'Straight From Fields',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60),
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: 400), // Adjust max width as needed
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: 400), // Adjust max width as needed
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle login
                },
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 24),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor:
                      Colors.white, // This sets the text color to white
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  // Handle sign up
                },
                child: Text('Sign Up'),
                style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 115, vertical: 21),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: AppColors.darkGreen),
              ),
              SizedBox(height: 20),
              Text(
                'Or Log In with',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 48.0,
                    height: 48.0,
                    child: IconButton(
                      icon:
                          Image.asset('assets/google_icon.png'), // Google icon
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 48.0,
                    height: 48.0,
                    child: IconButton(
                      icon: Image.asset('assets/fb_icon.png'), // Facebook icon
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 48.0,
                    height: 48.0,
                    child: IconButton(
                      icon: Image.asset(
                          'assets/linked_icon.png'), // LinkedIn icon
                      onPressed: () {
                        // Handle LinkedIn login
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('FarmMart Inc. © 2024'),
            ],
          ),
        ),
      ),
    );
  }
}
