import 'package:flutter/material.dart';
import 'models/product.dart';

class SampleDataScreen extends StatelessWidget {
  // Function to create 10 sample products
  Future<void> addSampleProducts() async {
    for (int i = 0; i < 10; i++) {
      Product product = Product(
        bidNow: 100 + i,
        bidStart: 100,
        buyNow: 200,
        category: "Unprocessed Grains",
        created: DateTime.now(),
        description: "Sample description $i",
        end: DateTime.now().add(Duration(days: 10)),
        images: ["url1", "url2", "url3"],
        metric: "Ton",
        name: "3T of Organic White Rice $i",
        quantity: "${50 + i}",
        seller: "/listings/users",
        thumbnail: "",
      );
      await product.addToFirestore(); // Add each product to Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Sample Products')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await addSampleProducts();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Sample data added to Firestore"),
            ));
          },
          child: Text('Add 10 Sample Products'),
        ),
      ),
    );
  }
}
