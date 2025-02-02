import 'package:flutter/material.dart';
import '../../colors.dart';

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
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to any color you want
        ),
        backgroundColor: AppColors.darkGreen,
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0, // Adjust the font size as needed
                ),
              ),
            ),
          ],
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
                Navigator.pushReplacementNamed(context, '/bisName');
              },
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
              child: Text('Next'),
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
