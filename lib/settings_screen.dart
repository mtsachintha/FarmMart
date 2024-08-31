import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SettingsScreen()));
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the ListView
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30.0, // Increase the size by setting the radius
                backgroundImage: AssetImage(
                    'assets/profile_image.png'), // Use your image here
              ),
              title: Text('Evo Green House'),
              onTap: () {
                // Handle profile tap
              },
            ),
            SizedBox(
                height: 12.0), // Add padding between the two ListTile widgets
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Profile Settings'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // Smaller icon size
              ),
              onTap: () {
                // Handle job seeking status tap
              },
            ),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Order History'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // Smaller icon size
              ),
              onTap: () {
                // Handle linked accounts tap
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // Smaller icon size
              ),
              onTap: () {
                // Handle notification tap
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // Smaller icon size
              ),
              onTap: () {
                // Handle security tap
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // Smaller icon size
              ),
              onTap: () {
                // Handle language tap
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help Center'),
              onTap: () {
                // Handle help center tap
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Invite Friends'),
              onTap: () {
                // Handle invite friends tap
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate us'),
              onTap: () {
                // Handle rate us tap
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle privacy policy tap
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms of Services'),
              onTap: () {
                // Handle terms of services tap
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Handle about us tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red, // Set the icon color to red
              ),
              title: Text(
                'Log Out',
                style:
                    TextStyle(color: Colors.red), // Set the text color to red
              ),
              onTap: () {
                // Handle log out tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
