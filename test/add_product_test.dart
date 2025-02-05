import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_application/colors.dart';
import 'package:farm_application/screens/main/add_product.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  testWidgets('AddProductPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddProductPage(),
      ),
    );

    // Verify that the title is displayed
    expect(find.text("Add a Product"), findsOneWidget);

    // Verify text fields exist
    expect(find.byType(TextField), findsNWidgets(5)); // Correct

    // Verify category and type dropdowns exist
    expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));

    // Verify buttons exist
    expect(find.text("Draft"), findsOneWidget);
  });

  testWidgets('Form submission with missing fields shows error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AddProductPage()),
      ),
    );

    await tester.tap(find.text("Send for Review"));
    await tester.pump();

    expect(find.text("Please fill in all fields"), findsOneWidget);
  });
}
