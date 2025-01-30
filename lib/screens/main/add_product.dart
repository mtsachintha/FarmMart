import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    if (bidStartController.text.isEmpty ||
        buyNowController.text.isEmpty ||
        selectedCategory == null ||
        createdDate == null ||
        endDate == null ||
        descriptionController.text.isEmpty ||
        nameController.text.isEmpty ||
        quantityController.text.isEmpty ||
        sellerController.text.isEmpty ||
        thumbnailController.text.isEmpty) {
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
        'created': createdDate!.toIso8601String(),
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully")),
      );

      Navigator.pop(context); // Go back after submission
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
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              TextField(
                controller: descriptionController,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(createdDate == null
                        ? "Created Date: Not Selected"
                        : "Created Date: ${DateFormat.yMMMd().format(createdDate!)}"),
                  ),
                  ElevatedButton(
                    onPressed: () => pickDate(isCreatedDate: true),
                    child: const Text("Pick Date"),
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
                    child: const Text("Pick Date"),
                  ),
                ],
              ),
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
                controller: sellerController,
                decoration: const InputDecoration(labelText: "Seller"),
              ),
              TextField(
                controller: thumbnailController,
                decoration: const InputDecoration(labelText: "Thumbnail URL"),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitProduct,
                child: const Text("Submit Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
