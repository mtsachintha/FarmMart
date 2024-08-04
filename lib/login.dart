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
                    width: 48,
                    height: 48,
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
                          fontSize: 20,
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle login
                },
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  // Handle sign up
                },
                child: Text('Sign Up'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Text('Or Log In with'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 64.0,
                    height: 64.0,
                    child: IconButton(
                      icon:
                          Image.asset('assets/google_icon.png'), // Google icon
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                  ),
                  SizedBox(
                    width: 64.0,
                    height: 64.0,
                    child: IconButton(
                      icon: Image.asset(
                          'assets/facebook_icon.png'), // Facebook icon
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                  ),
                  SizedBox(
                    width: 64.0,
                    height: 64.0,
                    child: IconButton(
                      icon: Image.asset(
                          'assets/linkedin_icon.png'), // LinkedIn icon
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
