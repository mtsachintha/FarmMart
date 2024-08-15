import 'package:flutter/material.dart';
import 'colors.dart';

class BisTypeSelectionScreen extends StatefulWidget {
  @override
  _BisTypeSelectionScreenState createState() => _BisTypeSelectionScreenState();
}

class _BisTypeSelectionScreenState extends State<BisTypeSelectionScreen> {
  String _selectedGender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 18.0, // Change this value to adjust the text size
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
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
                      "What's Your Buisness Type?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "You can change who sees your gender on your profile later.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RadioListTile<String>(
                            title: const Text('Individual'),
                            value: 'Individual',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            subtitle: const Text(
                              "Select Custom to choose another gender, or if you'd rather not say.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0), // Adjust padding
                          ),
                          RadioListTile<String>(
                            title: const Text('Group'),
                            value: 'Group',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            subtitle: const Text(
                              "Select Custom to choose another gender, or if you'd rather not say.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0), // Adjust padding
                          ),
                          RadioListTile<String>(
                            title: const Text('Organization'),
                            value: 'Organization',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            subtitle: const Text(
                              "Select Custom to choose another gender, or if you'd rather not say.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0), // Adjust padding
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 18),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                foregroundColor:
                    Colors.white, // This sets the text color to white
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
