import 'package:flutter/material.dart';
import 'intro_page.dart'; // Import the new file
import 'login.dart'; // Make sure this import statement is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class FarmMartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          IntroPage(),
          // Add more pages if needed
        ],
      ),
    );
  }
}
