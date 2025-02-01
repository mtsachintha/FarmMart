import 'package:farm_application/screens/main/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/main/home_screen.dart';
import 'screens/orderConfirmation/payment_screen.dart';
import 'screens/main/auction_screen.dart';
import 'screens/main/chat_screen.dart';
import 'colors.dart';

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
      initialRoute: '/', // Starting route
      routes: {
        '/': (context) => BuildHomeScreen(),
        '/main': (context) => BuildHomeScreen(),
        '/login': (context) => PaymentScreen(),
      },
    );
  }
}

class BuildHomeScreen extends StatefulWidget {
  @override
  _BuildHomeScreenState createState() => _BuildHomeScreenState();
}

class _BuildHomeScreenState extends State<BuildHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AuctionScreen(),
    ChatListScreen(),
    SettingsScreen()
  ];

  final List<AppBar> _appBars = [
    buildHomeAppBar(),
    buildAuctionAppBar(),
    buildSecondAppBar(),
    buildSettingsAppBar(),
  ];

  void _onItemTapped(int index) {
    if (!mounted) return; // Prevent calling setState on an unmounted widget
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreOrange);
            }
            return TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: AppColors.defaultGray);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.foreOrange),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.gavel_outlined),
              selectedIcon:
                  Icon(Icons.gavel_rounded, color: AppColors.foreOrange),
              label: 'Auction',
            ),
            NavigationDestination(
              icon: Icon(Icons.message_outlined),
              selectedIcon: Icon(Icons.message, color: AppColors.foreOrange),
              label: 'Messages',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.foreOrange),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
