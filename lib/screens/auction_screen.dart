import 'package:farm_application/models/auction.dart';
import 'package:farm_application/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_application/colors.dart';

class BidItem {
  final String refNo;
  final String title;
  final int yourBid;
  final int going;
  final int buyNow;
  final String endIn;

  BidItem({
    required this.refNo,
    required this.title,
    required this.yourBid,
    required this.going,
    required this.buyNow,
    required this.endIn,
  });
}

class AuctionScreen extends StatefulWidget {
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BidItem> bidItems = [];

  @override
  void initState() {
    super.initState();
    fetchBidItems();
  }

  void fetchBidItems() async {
    List<BidItem> fetchedBidItems = [];
    QuerySnapshot auctionSnapshot = await firestore.collection('auction').get();

    for (var doc in auctionSnapshot.docs) {
      Auction auction = Auction.fromMap(doc.data() as Map<String, dynamic>);
      DocumentSnapshot productSnapshot =
          await firestore.collection('listings').doc(auction.ref).get();

      if (productSnapshot.exists) {
        Product product =
            Product.fromMap(productSnapshot.data() as Map<String, dynamic>);
        String endIn = calculateTimeRemaining(product.end);

        BidItem bidItem = BidItem(
          refNo: auction.ref,
          title: product.name,
          yourBid: auction.bid,
          going: product.bidNow,
          buyNow: product.buyNow,
          endIn: endIn,
        );

        fetchedBidItems.add(bidItem);
      }
    }

    setState(() {
      bidItems = fetchedBidItems;
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
      body: BidItemList(bidItems: bidItems),
    );
  }
}

class BidItemList extends StatelessWidget {
  final List<BidItem> bidItems;

  BidItemList({required this.bidItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: bidItems.length,
      itemBuilder: (context, index) {
        final item = bidItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ref: ${item.refNo}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBidColumn('Your Bid', item.yourBid),
                    _buildBidColumn('Buy Now', item.buyNow),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBidGoingAt("Going At", item.going),
                    _buildBidEndsIn("Ends In", item.endIn),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildViewListingButton(),
                    _buildBidAgainButton(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBidColumn(String label, int amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        SizedBox(height: 4.0),
        Text(
          'Rs. ${NumberFormat.currency(locale: 'en_LK', symbol: '').format(amount)}',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBidGoingAt(String label, int amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        SizedBox(height: 4.0),
        Text(
          'Rs. ${NumberFormat.currency(locale: 'en_LK', symbol: '').format(amount)}',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ],
    );
  }

  Widget _buildBidEndsIn(String label, String endIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        SizedBox(height: 4.0),
        Text(endIn,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBidAgainButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text('Bid Again',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildViewListingButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text('View Listing >>', style: TextStyle(color: Colors.grey[600])),
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

void main() => runApp(MaterialApp(home: AuctionScreen()));
