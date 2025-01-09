import 'package:flutter/material.dart';
import '../../colors.dart';

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.center, // Aligns the logo to the left
                  child: Image.asset(
                    'assets/logo_banner_black.png', // Replace with your logo asset path
                    height: 90,
                  ),
                ),
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
                  Navigator.pushReplacementNamed(context, '/main');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor:
                      Colors.white, // This sets the text color to white
                ),
                child: Text('Log In'),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  // Handle sign up
                },
                style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 115, vertical: 16),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: AppColors.darkGreen),
                child: Text('Sign Up'),
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
