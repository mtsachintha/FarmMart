import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_application/screens/main/home_screen.dart';
import 'package:flutter/material.dart';

// Mock Firestore Dependencies
class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}

void main() {
  group('Fetch Products', () {
    late MockFirestore mockFirestore;
    late MockCollectionReference mockCollection;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockQueryDocumentSnapshot mockQueryDoc;

    setUp(() {
      mockFirestore = MockFirestore();
      mockCollection = MockCollectionReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDoc = MockQueryDocumentSnapshot();
    });

    testWidgets('fetchProducts retrieves Firestore data correctly',
        (WidgetTester tester) async {
      // Arrange
      when(mockFirestore.collection('listings')).thenReturn(
          mockCollection as CollectionReference<Map<String, dynamic>>);
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc]);
      when(mockQueryDoc.data()).thenReturn({
        'name': 'Organic Rice',
        'seller': 'GreenFarm',
        'thumbnail': 'image.jpg',
        'quantity': '5 kg',
      });

      // Create HomeScreen Widget
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Wait for async operations
      await tester.pump();

      // Verify state update
      final productTitleFinder = find.text('Organic Rice');
      expect(productTitleFinder, findsOneWidget);
    });
  });
}
