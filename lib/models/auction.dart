import 'package:cloud_firestore/cloud_firestore.dart';

class Auction {
  final String ref;
  final int bid;

  Auction({
    required this.ref,
    required this.bid,
  });

  // Convert the auction to a Map<String, dynamic> for Firestore
  Map<String, dynamic> toJson() {
    return {
      'ref': ref,
      'bid': bid,
    };
  }

  factory Auction.fromMap(Map<dynamic, dynamic> map) {
    return Auction(
      ref: (map['ref'] ?? '') as String,
      bid: (map['bid'] ?? 0) as int,
    );
  }

  // Function to add auction to Firestore
  Future<void> addToFirestore() async {
    await FirebaseFirestore.instance.collection('auctions').add(toJson());
  }
}
