import 'package:flutter/material.dart';
import 'package:farm_application/colors.dart';

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
                      "₹2560.00",
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
              onPressed: () {},
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
