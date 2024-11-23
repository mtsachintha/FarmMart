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

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
      bidNow: (map['bidNow'] ?? 0) as int,
      bidStart: (map['bidStart'] ?? 0) as int,
      buyNow: (map['buyNow'] ?? 0) as int,
      category: (map['category'] ?? '') as String,
      created: map['created'] != null
          ? (map['created'] is Timestamp
              ? (map['created'] as Timestamp).toDate()
              : DateTime.parse(map['created'] as String))
          : DateTime.now(),
      description: (map['description'] ?? '') as String,
      end: map['end'] != null
          ? (map['end'] is Timestamp
              ? (map['end'] as Timestamp).toDate()
              : DateTime.parse(map['end'] as String))
          : DateTime.now(),
      images: map['images'] != null
          ? List<String>.from(map['images'] as List<dynamic>)
          : [],
      metric: (map['metric'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      quantity: (map['quantity'] ?? '') as String,
      seller: map['seller'] is DocumentReference
          ? (map['seller'] as DocumentReference).path
          : (map['seller'] ?? '')
              as String, // Convert DocumentReference to path, or fallback to empty string
      thumbnail: (map['thumbnail'] ?? '') as String,
    );
  }

  // Function to add product to Firestore
  Future<void> addToFirestore() async {
    await FirebaseFirestore.instance.collection('listings').add(toJson());
  }
}
