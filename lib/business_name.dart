import 'package:flutter/material.dart';
import 'colors.dart';

class BusinessNameScreen extends StatelessWidget {
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
                      'What is your business name?',
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
                      width: 520, // Set the desired max width here
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Store Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  16.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 520, // Set the desired max width here
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  16.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 520, // Set the desired max width here
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  16.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
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
