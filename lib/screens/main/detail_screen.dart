import 'package:flutter/material.dart';
import '../../colors.dart';
import '../../models/product.dart';
import 'package:farm_application/screens/orderConfirmation/bidding_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  // Constructor accepting Product object
  const ProductDetailScreen({super.key, required this.product});

  String formatPrice(int price) {
    if (price >= 1000000) {
      return 'Rs ${(price / 1000000)}M'; // 2.0M
    } else if (price >= 1000) {
      return 'Rs ${(price / 1000)}K'; // 20K
    }
    return 'Rs $price';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar section with green background
            Container(
              color: AppColors.darkGreen,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Product Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Image and Carousel
            Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: Alignment
                        .bottomCenter, // Align elements to the bottom center
                    children: [
                      // PageView for sliding images
                      PageView(
                        children: product.images.map((imageUrl) {
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                      ),
                      // Static Indicators
                      Positioned(
                        bottom:
                            10, // Position the indicators slightly above the bottom
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(product.images.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? Colors.white
                                    : Colors.grey, // Highlight the first dot
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),

            // Details Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'by ${product.seller}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        formatPrice(2580000), // Change the value dynamically
                        style: TextStyle(
                          color: AppColors.foreOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      if (product.bidNow < product.buyNow) // If discounted
                        Text(
                          '\$${product.buyNow.toStringAsFixed(2)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Bottom Buy Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark_add_rounded),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for Buy
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.midDarkGreen,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Space between the buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BiddingScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkGreen,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Bid',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
