import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farm_application/screens/orderConfirmation/bidding_screen.dart';
import 'package:farm_application/screens/main/detail_screen.dart';
import 'package:farm_application/models/product.dart';

void main() {
  final Product product = Product(
    bidNow: 1000,
    bidStart: 500,
    buyNow: 1500,
    category: "Fruits",
    created: DateTime.now(),
    description: "Fresh organic apples",
    end: DateTime.now().add(Duration(days: 7)),
    images: [
      "https://example.com/image1.jpg",
      "https://example.com/image2.jpg"
    ],
    metric: "kg",
    name: "Apple",
    quantity: "10",
    seller: "John's Farm",
    thumbnail: "https://example.com/thumbnail.jpg",
  );

  testWidgets('ProductDetailScreen renders correctly',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: ProductDetailScreen(product: product)));

    expect(find.text('Product Detail'), findsOneWidget);
    expect(find.text('Fresh Apples'), findsOneWidget);
    expect(find.text('by John\'s Farm'), findsOneWidget);
    expect(find.text('High-quality fresh apples directly from the farm.'),
        findsOneWidget);
  });

  testWidgets('Back button pops the screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: ProductDetailScreen(product: product)),
    ));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
  });

  testWidgets('Bidding button navigates to BiddingScreen',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: ProductDetailScreen(product: product)));
    await tester.tap(find.text('Bid'));
    await tester.pumpAndSettle();
    expect(find.byType(BiddingScreen), findsOneWidget);
  });

  testWidgets('Price formatting works correctly', (WidgetTester tester) async {
    final screen = ProductDetailScreen(product: product);
    expect(screen.formatPrice(250), 'Rs 250');
    expect(screen.formatPrice(2500), 'Rs 2.5K');
    expect(screen.formatPrice(2500000), 'Rs 2.5M');
  });

  testWidgets('Image carousel displays images', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: ProductDetailScreen(product: product)));
    expect(find.byType(PageView), findsOneWidget);
  });

  testWidgets('Buy button exists and is enabled', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: ProductDetailScreen(product: product)));
    expect(find.text('Buy'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.text('Buy')).enabled, isTrue);
  });
}
