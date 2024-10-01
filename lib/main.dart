import 'package:farm_application/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'sample_data.dart'; // Import the screen with the AppBar
import 'screens/home_screen.dart'; // Import the screen with the AppBar
import 'screens/auction_screen.dart'; // Import the screen with the AppBar
import 'screens/chat_screen.dart'; // Import the screen with the AppBar
import 'colors.dart';
// Import the screen with the AppBar

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBAoZMQ_X_-oyGaWiSu5CCFyYqxbejO9bY',
    appId: '1:527035042565:android:2fcb0208513e2d1882456c',
    messagingSenderId: '527035042565',
    projectId: 'farmmart-c0146',
    storageBucket: 'farmmart-c0146.appspot.com',
  ));
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
    SampleDataScreen(),
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent, // Remove indicator
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreOrange); // Selected label color
            }
            return TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: AppColors.defaultGray); // Unselected label color
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home,
                  color: AppColors.foreOrange), // Selected icon color
              label: 'Home', // Empty label
            ),
            NavigationDestination(
              icon: Icon(Icons.gavel_outlined),
              selectedIcon: Icon(Icons.gavel_rounded,
                  color: AppColors.foreOrange), // Selected icon color
              label: 'Auction', // Empty label
            ),
            NavigationDestination(
              icon: Icon(Icons.message_outlined),
              selectedIcon: Icon(Icons.message,
                  color: AppColors.foreOrange), // Selected icon color
              label: 'Messages', // Empty label
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person,
                  color: AppColors.foreOrange), // Selected icon color
              label: 'Profile', // Empty label
            ),
          ],
        ),
      ),
    );
  }
}
