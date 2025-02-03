import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:farm_application/colors.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Controllers
  final TextEditingController bidStartController = TextEditingController();
  final TextEditingController buyNowController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController sellerController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();

  // Dropdown values
  String? selectedCategory;
  String? selectedType;
  DateTime? createdDate;
  DateTime? endDate;
  String selectedMetric = 'kg'; // Default value

  // Dropdown options
  final List<String> categories = [
    "Rooty & Tuberous Vegetables",
    "Leafy Vegetables",
    "Fruits"
  ];

  final List<String> types = ["carrot", "potato", "tomato"];

  // Submit the product data to Firestore
  void submitProduct() async {
    if (descriptionController.text.isEmpty ||
        nameController.text.isEmpty ||
        quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('products') // Firestore collection
          .add({
        'bid_start': int.parse(bidStartController.text),
        'buy_now': int.parse(buyNowController.text),
        'category': selectedCategory,
        'created': "",
        'description': descriptionController.text,
        'end': endDate!.toIso8601String(),
        'images': [
          "https://firebasestorage.googleapis.com/v0/b/farmmart-c0146.appspot.com/o/carrot_1.png?alt=media&token=db729496-d3c7-4ab9-a6b9-f9d6966e73bd",
          "https://firebasestorage.googleapis.com/v0/b/farmmart-c0146.appspot.com/o/carrot_1.png?alt=media&token=db729496-d3c7-4ab9-a6b9-f9d6966e73bd",
          "https://firebasestorage.googleapis.com/v0/b/farmmart-c0146.appspot.com/o/carrot_1.png?alt=media&token=db729496-d3c7-4ab9-a6b9-f9d6966e73bd"
        ],
        'metric': 'Ton',
        'name': nameController.text,
        'quantity': quantityController.text,
        'seller': sellerController.text,
        'thumbnail': thumbnailController.text,
        'type': selectedType,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 16),
                const Text(
                  "Item Successfully Sent for Review!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Navigate back to home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Go Back"),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // Date Picker
  Future<void> pickDate({required bool isCreatedDate}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCreatedDate) {
          createdDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  fontSize: 18.0, // Adjust the font size as needed
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2, // Adjust the flex ratio as needed
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quantity",
                      ),
                    ),
                  ),
                  const SizedBox(
                      width:
                          8), // Add spacing between the TextField and Dropdown
                  Expanded(
                    flex: 1, // Adjust the flex ratio as needed
                    child: DropdownButtonFormField<String>(
                      value:
                          selectedMetric, // A variable to hold the selected metric
                      items: ['kg', 'ton', 'lb', 'g'] // Add more as needed
                          .map((metric) => DropdownMenuItem(
                                value: metric,
                                child: Text(metric),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Update the selectedMetric variable
                        selectedMetric = value!;
                      },
                      decoration: InputDecoration(
                        labelText: "Metric",
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: bidStartController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Bid Start"),
              ),
              TextField(
                controller: buyNowController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Buy Now"),
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: types
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Type"),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/placeholder_veg.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/placeholder_veg.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/placeholder_veg.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Created Date: ${DateFormat.yMMMd().add_jm().format(DateTime.now())}",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(endDate == null
                        ? "End Date: Not Selected"
                        : "End Date: ${DateFormat.yMMMd().format(endDate!)}"),
                  ),
                  ElevatedButton(
                    onPressed: () => pickDate(isCreatedDate: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.darkGreen, // Updated background color
                      foregroundColor: Colors.white, // Text color set to white
                    ),
                    child: const Text("Pick Date"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: submitProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Send for Review",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.midGray,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Draft",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
