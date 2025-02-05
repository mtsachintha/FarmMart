import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farm_application/screens/onboarding/login.dart'; // Adjust import as per your project

void main() {
  testWidgets('LoginPage should render all UI elements correctly',
      (WidgetTester tester) async {
    // Load the LoginPage widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Check if email and password text fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Check if the buttons exist
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Check for social login icons
    expect(find.byType(IconButton), findsNWidgets(3));
  });

  testWidgets('Email and Password fields should accept input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Enter email
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    // Enter password
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Verify that the input fields contain the entered text
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('Log In button should navigate to /main',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      routes: {'/main': (context) => Scaffold(body: Text('Main Screen'))},
    ));

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.text('Main Screen'), findsOneWidget);
  });

  testWidgets('Sign Up button should navigate to /bisType',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      routes: {'/bisType': (context) => Scaffold(body: Text('Signup Screen'))},
    ));

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Signup Screen'), findsOneWidget);
  });
}
