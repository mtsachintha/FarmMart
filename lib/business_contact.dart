import 'package:flutter/material.dart';
import 'colors.dart';

class BusinessContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 18.0, // Change this value to adjust the text size
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the children horizontally
                  children: [
                    Text(
                      'What are your contact details?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You can request to change the business type of your profile later',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      width:
                          520, // Set the desired max width for the entire row
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '+94',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        16.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Add some space between the TextField and the button
                          TextButton(
                            onPressed: () {
                              // Handle the verification action here
                            },
                            child: Text('Verify'),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Colors.green, // Set the text color to green
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors
                                    .green, // Set the text color if needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width:
                          520, // Set the desired max width for the entire row
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        16.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Add some space between the TextField and the button
                          TextButton(
                            onPressed: () {
                              // Handle the verification action here
                            },
                            child: Text('Verify'),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Colors.green, // Set the text color to green
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors
                                    .green, // Set the text color if needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // Handle login
                      },
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 18),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        foregroundColor:
                            Colors.white, // This sets the text color to white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
