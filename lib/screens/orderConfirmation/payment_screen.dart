import 'package:flutter/material.dart';
import 'package:farm_application/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:farm_application/screens/main/home_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "Wallet UPI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: AppColors.darkGreen,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Stepper Header
          Container(
            color: AppColors.lowDarkGreen,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStepperCircle("1", true),
                Expanded(
                  child: Divider(color: AppColors.darkGreen, thickness: 2),
                ),
                _buildStepperCircle("2", true),
                Expanded(
                  child: Divider(color: AppColors.darkGreen, thickness: 2),
                ),
                _buildStepperCircle("3", true),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Saved Cards Section
                  _buildSavedCardSection("Sales Agreement", ""),
                  _buildSavedCardSection("Export Certification", ""),
                  _buildSavedCardSection("Payment Details", ""),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "RS 12.25M",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                final firestore = FirebaseFirestore.instance;
                final docRef = firestore.collection('price-data').doc('carrot');

                final today = DateTime.now();
                final formattedDate = DateFormat('yyyy-MM-dd')
                    .format(today); // Example: 2025-01-23
                const newPrice =
                    510; // Set the price dynamically based on input

                await firestore.runTransaction((transaction) async {
                  final snapshot = await transaction.get(docRef);

                  if (snapshot.exists) {
                    final data = snapshot.data() as Map<String, dynamic>;

                    if (data.containsKey(formattedDate)) {
                      // Date exists, append new price
                      List<dynamic> prices = List.from(data[formattedDate]);
                      prices.add(newPrice);
                      transaction.update(docRef, {formattedDate: prices});
                    } else {
                      // Date does not exist, create new entry
                      transaction.update(docRef, {
                        formattedDate: [newPrice]
                      });
                    }
                  } else {
                    // If the document itself does not exist, create it
                    transaction.set(docRef, {
                      formattedDate: [newPrice]
                    });
                  }
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );

                print('Price updated successfully.');
              },
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperCircle(String step, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? AppColors.darkGreen : Colors.grey,
          child: Text(
            step,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSavedCardSection(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle CVV input
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
              ),
              child: const Text(
                "Download",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String option) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: RadioListTile<String>(
        value: option,
        groupValue: selectedPayment,
        onChanged: (value) {
          setState(() {
            selectedPayment = value!;
          });
        },
        title: Text(option),
        activeColor: Colors.orange,
      ),
    );
  }
}
