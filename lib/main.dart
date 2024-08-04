import 'package:flutter/material.dart';
import 'intro_page.dart'; // Import the new file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FarmMartScreen(),
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
