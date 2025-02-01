import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:farm_application/colors.dart';

class AuctionScreen extends StatefulWidget {
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<AuctionCard> auctions = [];

  @override
  void initState() {
    super.initState();
    fetchUserAuctions();
  }

  void fetchUserAuctions() async {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc('@evogreenhouse').get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      Map<String, dynamic>? auctionMap =
          userData?['auction'] as Map<String, dynamic>?;

      if (auctionMap != null) {
        List<AuctionCard> auctionCards = [];
        for (var entry in auctionMap.entries) {
          String itemId = entry.value['itemId'];
          int yourBid = int.tryParse(entry.value['bid'].toString()) ?? 0;

          DocumentSnapshot listingSnapshot =
              await firestore.collection('listings').doc(itemId).get();
          if (listingSnapshot.exists) {
            Map<String, dynamic>? listingData =
                listingSnapshot.data() as Map<String, dynamic>?;

            if (listingData != null) {
              DateTime endDate = (listingData['end'] as Timestamp).toDate();
              auctionCards.add(AuctionCard(
                title: listingData['name'] ?? '',
                location: listingData['location'] ?? '',
                quantity: listingData['quantity'] ?? "0",
                status:
                    DateTime.now().isBefore(endDate) ? 'Available' : 'Expired',
                imageUrl: listingData['thumbnail'] ??
                    'https://via.placeholder.com/150',
                start: (listingData['start'] as Timestamp).toDate(),
                end: endDate,
                remaining: calculateTimeRemaining(endDate),
                yourBid: yourBid,
                bidIncrement: listingData['bidIncrement'] ?? 0,
                goingAt: listingData['goingAt'] ?? 0,
              ));
            }
          }
        }
        setState(() {
          auctions = auctionCards;
        });
      }
    }
  }

  String calculateTimeRemaining(DateTime endDate) {
    final Duration remaining = endDate.difference(DateTime.now());
    if (remaining.inDays > 0) {
      return '${remaining.inDays} Days';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} Hours';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes} Minutes';
    } else {
      return 'Ended';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: auctions.length,
        itemBuilder: (context, index) {
          return auctions[index];
        },
      ),
    );
  }
}

class AuctionCard extends StatelessWidget {
  final String title;
  final String location;
  final String quantity;
  final String status;
  final String imageUrl;
  final DateTime start;
  final DateTime end;
  final String remaining;
  final int yourBid;
  final int bidIncrement;
  final int goingAt;

  AuctionCard({
    required this.title,
    required this.location,
    required this.quantity,
    required this.status,
    required this.imageUrl,
    required this.start,
    required this.end,
    required this.remaining,
    required this.yourBid,
    required this.bidIncrement,
    required this.goingAt,
  });

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Location: $location',
                          style: TextStyle(color: Colors.black54)),
                      Text('Quantity: $quantity',
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 24.0, thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailColumn('Start', DateFormat.MMMd().format(start)),
                _buildDetailColumn('End', DateFormat.MMMd().format(end)),
                _buildDetailColumn('Remaining', remaining),
              ],
            ),
            Divider(height: 24.0, thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailColumn('Your Bid',
                    'Rs. ${NumberFormat.compact().format(yourBid)}'),
                _buildDetailColumn('Bid Increment',
                    'Rs. ${NumberFormat.compact().format(bidIncrement)}'),
                _buildDetailColumn('Going At',
                    'Rs. ${NumberFormat.compact().format(goingAt)}'),
              ],
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                text: 'Status: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: status == 'Available' ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildAuctionAppBar() {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppColors.darkGreen,
    title: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Auction",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20.0, // Adjust the font size as needed
            ),
          ),
        ),
        Spacer(), // Pushes the icon to the right
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.bookmarks_outlined, color: Colors.white),
            onPressed: () {
              // Action for bookmark icon tap
            },
          ),
        ),
      ],
    ),
  );
}
