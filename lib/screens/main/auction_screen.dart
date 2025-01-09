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
  List<DocumentSnapshot> auctions = [];

  @override
  void initState() {
    super.initState();
    fetchAuctions();
  }

  void fetchAuctions() async {
    QuerySnapshot snapshot = await firestore.collection('auction').get();
    setState(() {
      auctions = snapshot.docs;
    });
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
          final auction = auctions[index].data() as Map<String, dynamic>;
          final DateTime endDate = (auction['end'] as Timestamp).toDate();
          return AuctionCard(
            title: auction['title'] ?? '',
            location: auction['location'] ?? '',
            quantity: auction['quantity'] ?? 0,
            status: auction['status'] ?? 'Active',
            imageUrl: auction['imageUrl'] ?? 'https://via.placeholder.com/150',
            start: (auction['start'] as Timestamp).toDate(),
            end: endDate,
            remaining: calculateTimeRemaining(endDate),
            yourBid: auction['yourBid'] ?? 0,
            bidIncrement: auction['bidIncrement'] ?? 0,
            goingAt: auction['goingAt'] ?? 0,
          );
        },
      ),
    );
  }
}

class AuctionCard extends StatelessWidget {
  final String title;
  final String location;
  final int quantity;
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
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text('Location: ',
                              style: TextStyle(color: Colors.black54)),
                          SizedBox(width: 4.0),
                          Text(location,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text('Quantity: ',
                              style: TextStyle(color: Colors.black54)),
                          Text('$quantity Ton',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 24.0, thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailColumn('Start:', DateFormat.yMMMd().format(start)),
                _buildDetailColumn('End:', DateFormat.yMMMd().format(end)),
                _buildDetailColumn('Remaining:', remaining),
              ],
            ),
            Divider(height: 24.0, thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailColumn('Your Bid:',
                    'Rs. ${NumberFormat.compact().format(yourBid)}'),
                _buildDetailColumn('Bid Increment:',
                    'Rs. ${NumberFormat.compact().format(bidIncrement)}'),
                _buildDetailColumn('Going At:',
                    'Rs. ${NumberFormat.compact().format(goingAt)}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Status: ',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 4.0),
                    Text('Available',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.launch, color: Colors.grey),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.black54)),
        SizedBox(height: 4.0),
        Text(value,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
      ],
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
