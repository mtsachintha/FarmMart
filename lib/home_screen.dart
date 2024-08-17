import 'package:flutter/material.dart';
import 'package:farm_application/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation logic here based on the selected index
  }

  @override
  Widget build(BuildContext context) {
    // Define the fixed width of each item
    final double itemWidth = 200;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 12),
            // Row for the three text buttons with borders and arrows
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align buttons to the left
              children: [
                SizedBox(width: 24),
                _buildTextButton("Quantity"),
                SizedBox(width: 8), // Space between buttons
                _buildTextButton("Price"),
                SizedBox(width: 8), // Space between buttons
                _buildTextButton("Type"),
              ],
            ),

            SizedBox(height: 16), // Space between buttons and the cards
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0, // Horizontal spacing between items
              runSpacing: 8.0, // Vertical spacing between rows
              children: items.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Image widget
                          Image.asset(
                            'assets/logo.png', // Replace with your logo asset path
                            height: 160,
                            width: 240,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8), // Space between image and text
                          // First text area
                          Text(
                            "Cards Title 1",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                              height: 4), // Space between title and subtitle
                          // Second text area
                          Text(
                            "Sub title",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                              height:
                                  4), // Space between subtitle and description
                          Text(
                            "MyStringsSample.card_text",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(
                              height:
                                  24), // Space between subtitle and description
                          // Footer text areas (in vertical alignment)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, // Aligns text to the right
                                children: <Widget>[
                                  Text(
                                    "Ends In:",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width:
                                          4), // Add some spacing between the texts
                                  Text(
                                    "2 Days",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, // Aligns text to the right
                                children: <Widget>[
                                  Text(
                                    "Buy Now:",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width:
                                          4), // Add some spacing between the texts
                                  Text(
                                    "Rs. 2M",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, // Aligns text to the right
                                children: <Widget>[
                                  Text(
                                    "Bid:",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange),
                                  ),
                                  SizedBox(
                                      width:
                                          4), // Add some spacing between the texts
                                  Text(
                                    "Rs. 1.6M",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build text buttons with borders and icons
  Widget _buildTextButton(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Border around the button
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton.icon(
        onPressed: () {
          // Add your onPressed function here
        },
        icon: Text(
          text,
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        label: Icon(Icons.arrow_drop_down), // Downward arrow icon
      ),
    );
  }
}

AppBar buildHomeAppBar() {
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

void main() => runApp(MaterialApp(home: HomeScreen()));
