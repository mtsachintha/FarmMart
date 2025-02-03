import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:farm_application/screens/main/home_screen.dart';
import 'package:farm_application/models/product.dart';

// Mock Firestore instance
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('HomeScreen UI loads properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Check if 'For You' button is present
    expect(find.text('For you'), findsOneWidget);

    // Check if 'Trending' button is present
    expect(find.text('Trending'), findsOneWidget);
  });

  testWidgets('Loading indicator is shown initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Expect to find a CircularProgressIndicator initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
