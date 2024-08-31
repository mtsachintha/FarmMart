import 'package:farm_application/settings_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the screen with the AppBar
import 'auction_screen.dart'; // Import the screen with the AppBar
import 'chat_screen.dart'; // Import the screen with the AppBar
import 'settings_screen.dart'; // Import the screen with the AppBar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuildHomeScreen(), // Use HomeScreen as the main screen
    );
  }
}

// Define your MyHomeScreen widget here
class BuildHomeScreen extends StatefulWidget {
  @override
  _BuildHomeScreenState createState() => _BuildHomeScreenState();
}

class _BuildHomeScreenState extends State<BuildHomeScreen> {
  int _selectedIndex = 0;

  // Define the different screens you want to navigate to
  final List<Widget> _screens = [
    HomeScreen(), // Home screen widget
    AuctionScreen(), // Placeholder for Auction screen
    ChatScreen(),
    SettingsScreen()
  ];

  final List<AppBar> _appBars = [
    buildHomeAppBar(), // Home screen widget
    buildAppBar(), // Placeholder for Auction screen
    buildHomeAppBar(), // Placeholder for Messages screen
    buildHomeAppBar(), // Placeholder for Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.gavel_outlined),
            selectedIcon: Icon(Icons.gavel_rounded),
            label: 'Auction',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
