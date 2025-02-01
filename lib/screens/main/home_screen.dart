import 'dart:convert';

import 'package:farm_application/screens/main/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_application/colors.dart';
import 'package:farm_application/models/product.dart';
import 'dart:math';
import 'package:google_generative_ai/google_generative_ai.dart';

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
      fetchAndGenerateKeywords();
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
  }

  //Start of Gemini Intergration

  Future<List<String>> getKeywordsFromGemini(List<String> titles) async {
    const apiKey = "AIzaSyChjB12t8w5bO8IyULrya5FduzCQtKywKQ";

    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );

    // Prepare the prompt to generate keywords
    final prompt = """
    Please give me a list of 10 keywords using this list of titles in a JSON format.
    Example response:
    ```json
    ["keyword1", "keyword2", "keyword3", ..., "keyword10"]
    ```
    Titles: ${titles.join(', ')}
  """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        String rawResponse = response.text!;

        // Extract the JSON part if wrapped in ```json ... ```
        RegExp jsonRegex =
            RegExp(r'```json\s*([\s\S]*?)\s*```', multiLine: true);
        Match? match = jsonRegex.firstMatch(rawResponse);

        String jsonResponse;
        if (match != null) {
          jsonResponse = match.group(1)!; // Extract JSON part
        } else {
          jsonResponse =
              rawResponse; // Assume whole response is JSON if no formatting
        }

        // Decode JSON string into a list
        List<dynamic> parsedJson = jsonDecode(jsonResponse);
        return parsedJson.map((e) => e.toString()).toList();
      } else {
        throw 'No response from Gemini';
      }
    } catch (e) {
      throw 'Error generating keywords: $e';
    }
  }

  void fetchAndGenerateKeywords() async {
    try {
      List<String> titles = await getUserFypTitles();
      print('Fetched Titles: $titles');

      keywords = await getKeywordsFromGemini(titles);
      print('Generated Keywords: $keywords');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<String>> getUserFypTitles() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot userDoc =
        await firestore.collection('users').doc('@evogreenhouse').get();

    if (userDoc.exists) {
      // Extract fyp titles
      List<dynamic> fypTitles = userDoc['fyp'] ?? [];
      return fypTitles.map((title) => title.toString()).toList();
    } else {
      throw 'User not found';
    }
  }

  //End of Gemini Intergration

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
                _buildBannerButton(
                    "For you", Icons.star, AppColors.yellow, fypProducts),
                SizedBox(width: 8),
                _buildBannerButton("Trending", Icons.local_fire_department,
                    AppColors.midOrange, fypProducts),
                SizedBox(width: 8),
                _buildBannerButton("Following", Icons.store,
                    AppColors.defaultGray, fypProducts),
                //_buildTextButton("Filters"),
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
                              addFYP(userId, item.name);
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

  Future<void> addFYP(String userId, String keyword) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the current array
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        // Cast the document data to a Map
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        // Safely get the 'fyp' field
        List<dynamic> currentArray = (data['fyp'] ?? []) as List<dynamic>;

        if (currentArray.length < 10) {
          // Add new keyword if array length is less than 10
          await docRef.update({
            'fyp': FieldValue.arrayUnion([keyword]),
          });
        } else {
          // Replace a random index with the new keyword if array length is 10
          int randomIndex =
              Random().nextInt(10); // Random index between 0 and 9
          currentArray[randomIndex] = keyword;

          // Update the entire array in Firestore
          await docRef.update({
            'fyp': currentArray,
          });
        }
        print("Document Added");
      } else {
        // Handle the case where the document doesn't exist
        print("Document does not exist");
      }
    } catch (e) {
      print("keyword updating hobbies: $e");
    }
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

  Widget _buildBannerButton(
      String text, IconData icon, Color color, VoidCallback onclickFun) {
    return TextButton.icon(
      onPressed: () {
        onclickFun();
      },
      icon: Icon(
        icon,
        color: color,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.defaultGray,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: AppColors.midGray,
          width: 1.0, // Thin border
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Optional: adds rounded corners
        ),
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
