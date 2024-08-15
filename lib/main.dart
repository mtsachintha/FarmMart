import 'package:flutter/material.dart';
import 'intro_page.dart';
import 'business_name.dart';
import 'business_contact.dart';
import 'business_type.dart';
import 'list_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListScreen(),
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
