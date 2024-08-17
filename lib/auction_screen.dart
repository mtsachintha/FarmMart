import 'package:flutter/material.dart';
import 'package:farm_application/colors.dart';

class MyResponsiveGridScreen extends StatefulWidget {
  @override
  _MyResponsiveGridScreenState createState() => _MyResponsiveGridScreenState();
}

class _MyResponsiveGridScreenState extends State<MyResponsiveGridScreen> {
  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    // Define the fixed width of each item
    final double itemWidth = 200;

    return Scaffold(body: SingleChildScrollView());
  }
}

AppBar buildAppBar() {
  return AppBar(
    titleSpacing: 0.0,
    title: Row(
      children: <Widget>[
        // Logo at the left
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/logo_banner.png', // Replace with your logo asset path
            height: 56, // Adjust logo height as needed
          ),
        ),
        // Expanded widget to fill available space
        Expanded(
          child: Container(),
        ),
        // Search bar aligned to the right with max width
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment:
                Alignment.centerRight, // Align the search bar to the right
            child: SizedBox(
              width: 260.0, // Set the max width of the search bar
              child: Container(
                height: 35.0, // Set the height of the search bar here
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the border radius
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.lightGray,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0), // Fine-tuned padding
                  ),
                  style: TextStyle(
                      color: Colors.black), // Text color changed to black
                ),
              ),
            ),
          ),
        ),
        // Account icon at the far right
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // Action for account icon tap
          },
        ),
      ],
    ),
  );
}

void main() => runApp(MaterialApp(home: MyResponsiveGridScreen()));
