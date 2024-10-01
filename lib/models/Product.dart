// lib/models/product.dart

import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore import

class Product {
  final int bidNow;
  final int bidStart;
  final int buyNow;
  final String category;
  final DateTime created;
  final String description;
  final DateTime end;
  final List<String> images;
  final String metric;
  final String name;
  final String quantity;
  final String seller;
  final String thumbnail;

  Product({
    required this.bidNow,
    required this.bidStart,
    required this.buyNow,
    required this.category,
    required this.created,
    required this.description,
    required this.end,
    required this.images,
    required this.metric,
    required this.name,
    required this.quantity,
    required this.seller,
    required this.thumbnail,
  });

  // Convert the product to a Map<String, dynamic> for Firestore
  Map<String, dynamic> toJson() {
    return {
      'bid_now': bidNow,
      'bid_start': bidStart,
      'buy_now': buyNow,
      'category': category,
      'created': created.toIso8601String(),
      'description': description,
      'end': end.toIso8601String(),
      'images': images,
      'metric': metric,
      'name': name,
      'quantity': quantity,
      'seller': seller,
      'thumbnail': thumbnail,
    };
  }

  // Function to add product to Firestore
  Future<void> addToFirestore() async {
    await FirebaseFirestore.instance.collection('listings').add(toJson());
  }
}
