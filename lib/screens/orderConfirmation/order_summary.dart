import 'package:flutter/material.dart';
import 'package:farm_application/colors.dart';
import 'package:farm_application/screens/orderConfirmation/payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final List<String> conditions = [
    "1. The agreement becomes effective upon signing by both parties.",
    "2. Delivery dates and locations shall be mutually agreed upon in writing.",
    "3. Both parties must notify each other promptly of any delays or issues that may affect the terms of the agreement.",
    "4. The seller guarantees to provide the agreed-upon quantity and variety of the product.",
  ];

  final List<String> qualityAssurance = [
    "1. Products will meet the grade, size, and quality standards specified in the agreement.",
    "2. All products will be free from contamination, adhering to local and international food safety regulations.",
    "3. The seller agrees to allow inspection of the product at the point of delivery by the buyer or their representative.",
    "4. Quality certificates, if applicable, will be provided upon request.",
  ];

  final List<String> payment = [
    "1. The buyer will make payment within the stipulated period (e.g., 14 days) from the date of delivery or invoice, whichever is earlier.",
    "2. Payment will be made via the agreed payment method (e.g., bank transfer, check, or cash).",
    "3. A late payment penalty of 2% per month may be applied to overdue amounts.",
    "4. The seller reserves the right to halt future deliveries until outstanding payments are settled.",
  ];

  final List<String> returnOrDisputes = [
    "1. The buyer must report any discrepancies or defects within 48 hours of delivery.",
    "2. Returns will only be accepted if the product is found to be defective or non-compliant with the agreed specifications.",
    "3. In the event of a dispute, both parties agree to attempt resolution through negotiation before pursuing legal action.",
    "4. If unresolved, disputes will be subject to arbitration under the rules of a mutually agreed arbitration body.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        title: const Text(
          "Contract",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
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
                _buildStepperCircle(context, "1", true),
                Expanded(
                    child: Divider(color: AppColors.darkGreen, thickness: 2)),
                _buildStepperCircle(context, "2", true),
                Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                _buildStepperCircle(context, "3", false),
              ],
            ),
          ),

          // Expanded Card Content
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Sales Agreement",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          const Text(
                            "Conditions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...conditions.map((condition) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(condition),
                              )),
                          const SizedBox(height: 4),
                          const Text(
                            "Quality Assurance",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...qualityAssurance.map((condition) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(condition),
                              )),
                          const SizedBox(height: 4),
                          const Text(
                            "Payment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...payment.map((condition) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(condition),
                              )),
                          const SizedBox(height: 8),
                          const Text(
                            "Return Policy",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...returnOrDisputes.map((condition) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(condition),
                              )),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Contact Seller",
                          style: TextStyle(color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Continue Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperCircle(BuildContext context, String step, bool isActive) {
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
}
