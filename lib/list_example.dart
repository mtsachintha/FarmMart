import 'package:flutter/material.dart';

class MyResponsiveGridScreen extends StatelessWidget {
  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    // Define the fixed width of each item
    final double itemWidth = 200;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Grid Example'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
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
                        SizedBox(height: 4), // Space between title and subtitle
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
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MyResponsiveGridScreen()));
