import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuctionScreen extends StatefulWidget {
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 24),
              _buildTextButton("Active"),
              SizedBox(width: 8),
              _buildTextButton("Sort By"),
              SizedBox(width: 8),
              _buildTextButton("Type"),
            ],
          ),
          Expanded(
            child: BidItemList(), // Here
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton.icon(
        onPressed: () {
          // Add your onPressed function here
        },
        icon: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
        label: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}

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

class BidItemList extends StatelessWidget {
  final List<BidItem> bidItems = [
    BidItem(
      refNo: '29991908DE',
      title: '3 Ton of Organic Unprocessed Rice with Low Water Density',
      yourBid: 1500000,
      going: 1600000,
      buyNow: 1800000,
      endIn: '2 Days',
    ),
    BidItem(
      refNo: '1087345AB',
      title: '2 Ton of Premium Grade Wheat',
      yourBid: 1200000,
      going: 1300000,
      buyNow: 1400000,
      endIn: '5 Days',
    ),
    BidItem(
      refNo: '457123CD',
      title: '1 Ton of Organic Corn',
      yourBid: 900000,
      going: 950000,
      buyNow: 1000000,
      endIn: '1 Day',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
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
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Rs. ${NumberFormat.currency(locale: 'en_LK', symbol: '').format(amount)}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBidGoingAt(String label, int amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Rs. ${NumberFormat.currency(locale: 'en_LK', symbol: '').format(amount)}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildBidEndsIn(String label, String endIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Rs. ${endIn.toString()}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBidAgainButton() {
    return ElevatedButton(
      onPressed: () {
        // Add your onPressed function here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'Bid Again',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white), // Text color
      ),
    );
  }

  Widget _buildViewListingButton() {
    return TextButton(
      onPressed: () {
        // Add your onPressed function here
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'View Listing >>',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    titleSpacing: 0.0,
    title: Row(
      children: <Widget>[
        // Logo at the left
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/logo_banner.png', // Replace with your logo asset path
            height: 56, // Adjust logo height as needed
          ),
        ),
        // Expanded widget to fill available space
        Expanded(
          child: Container(),
        ),
        TextButton(
          child: Text(
            "Switch to Selling",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
          ),
          onPressed: () {
            // Your code here
            print("Button pressed");
          },
        ),
        SizedBox(width: 16),
        // Search bar aligned to the right with max width
        // Account icon at the far right
        IconButton(
          icon: Icon(Icons.bookmarks_outlined),
          onPressed: () {
            // Action for account icon tap
          },
        ),
      ],
    ),
  );
}

void main() => runApp(MaterialApp(home: AuctionScreen()));
