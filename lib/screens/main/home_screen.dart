import 'package:farm_application/screens/main/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_application/colors.dart';
import 'package:farm_application/models/product.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> products = [];
  final String userId = "@evogreenhouse";
  List<String> keywords = ["Premium", "Organic", "Rice", "Farm"];
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    print("fetchProducts function called");
    QuerySnapshot querySnapshot = await firestore.collection('listings').get();

    setState(() {
      products = querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<Map<String, dynamic>>> searchWithMultipleKeywords(
      List<String> keywords) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> results = [];

    try {
      for (String keyword in keywords) {
        // Perform a query for each keyword
        QuerySnapshot querySnapshot = await firestore
            .collection('listings')
            .where('name', isGreaterThanOrEqualTo: keyword)
            .where('name', isLessThanOrEqualTo: keyword + '\uf8ff')
            .get();

        // Add each result to the results list
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Avoid adding duplicates (if needed)
          if (!results.any((element) => element['id'] == doc.id)) {
            results.add({...data, 'id': doc.id}); // Include document ID
          }
        }
      }

      return results;
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  void fypProducts() async {
    print("fypProducts function called");

    try {
      print("Before searchWithMultipleKeywords");
      results = await searchWithMultipleKeywords(keywords);
      print("After searchWithMultipleKeywords: $results");

      List<Product> fetchedProducts =
          results.map((result) => Product.fromMap(result)).toList();

      setState(() {
        products = fetchedProducts;
        print("Products updated in setState: $products");
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {});
    // Handle navigation logic here based on the selected index
  }

  @override
  Widget build(BuildContext context) {
    // Define the fixed width of each item
    const double itemWidth = 200;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTextButton("Filters"),
                _buildTextButton("Sort By"),
                _buildTextButton("Type"),
              ],
            ),
          ),
          products.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0, // Horizontal spacing between items
                      runSpacing: 8.0, // Vertical spacing between rows
                      children: products.map((item) {
                        return SizedBox(
                          width: itemWidth,
                          child: InkWell(
                            onTap: () {
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: item),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image widget
                                    Image.network(
                                      item.thumbnail,
                                      height: 160,
                                      width: 240,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Space between image and text
                                    // First text area
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            2), // Space between title and subtitle
                                    // Second text area
                                    Text(
                                      item.seller,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                        height:
                                            2), // Space between subtitle and description
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: AppColors
                                            .defaultGray, // Background color
                                        borderRadius: BorderRadius.circular(
                                            4.0), // Rounded corners
                                      ),
                                      child: Text(
                                        item.quantity,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white, // Text color
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            24), // Space between description and footer
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end, // Aligns text to the right
                                          children: <Widget>[
                                            Text(
                                              "Ends In:",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Spacing between texts
                                            Text(
                                              "2 Days",
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end, // Aligns text to the right
                                          children: <Widget>[
                                            Text(
                                              "Buy Now:",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Spacing between texts
                                            Text(
                                              "Rs. 2M",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end, // Aligns text to the right
                                          children: <Widget>[
                                            Text(
                                              "Bid:",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Spacing between texts
                                            Text(
                                              "Rs. 1.6M",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String text) {
    return TextButton.icon(
      onPressed: () {
        // Add your onPressed function here
      },
      icon: Text(
        text,
        style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: AppColors.defaultGray),
      ),
      label: Icon(
        Icons.arrow_drop_down,
        color: AppColors.defaultGray,
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

AppBar buildHomeAppBar() {
  const double searchBarHeight = 36.0;

  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppColors.darkGreen,
    title: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(
            'assets/logo_banner.png',
            height: 50,
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: 200.0,
            child: Material(
              elevation: 1.0, // Adds shadow for Material design
              borderRadius: BorderRadius.circular(
                  8.0), // Rounded corners for the Material container
              child: SizedBox(
                height: searchBarHeight,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    filled: true,
                    fillColor: AppColors
                        .whiteGray, // Background color of the search bar
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none, // Removes the outline border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.bookmarks_outlined, color: Colors.white),
            onPressed: () {
              // Action for account icon tap
            },
          ),
        ),
      ],
    ),
  );
}

void main() => runApp(MaterialApp(home: HomeScreen()));
