import 'package:flutter/material.dart';

class MyListScreen extends StatelessWidget {
  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom List Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Image widget
                    Image.asset(
                      'assets/logo.png', // Replace with your logo asset path
                      height: 120,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    // Add some spacing between the image and the text
                    Container(width: 20),
                    // Expanded widget to take up the remaining horizontal space
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Row for the main text fields
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Main text fields that take up all the free space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 16),
                                    Text(
                                      "Cards Title 1",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(height: 2),
                                    Text(
                                      "Sub title",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Container(height: 10),
                                    Text(
                                      "MyStringsSample.card_text",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Vertical column for the right corner text fields
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Right Text 1",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  Text(
                                    "Right Text 2",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  Text(
                                    "Right Text 3",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MyListScreen()));
