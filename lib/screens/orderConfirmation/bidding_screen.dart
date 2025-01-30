import 'package:farm_application/colors.dart';
import 'package:farm_application/screens/orderConfirmation/order_summary.dart';
import 'package:flutter/material.dart';

class BiddingScreen extends StatefulWidget {
  @override
  _BiddingScreenState createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  String _selectedLoanType = "Custom"; // Default selected button

  void _onLoanTypeSelected(String loanType) {
    setState(() {
      _selectedLoanType = loanType; // Update the selected loan type
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        title: const Text(
          "Bidding",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0, // Adjust the font size as needed
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    child: Divider(color: Colors.grey, thickness: 2),
                  ),
                  _buildStepperCircle(context, "2", false),
                  Expanded(
                    child: Divider(color: Colors.grey, thickness: 2),
                  ),
                  _buildStepperCircle(context, "3", false),
                ],
              ),
            ),

            // Main Content
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Live bidding header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 4.0),
                            const Icon(Icons.circle,
                                color: Colors.red, size: 12.0),
                            const SizedBox(width: 8.0),
                            const Text(
                              "Live",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "History >> ",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    const Text("Ends In:"),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeBox("16", "hrs"),
                        _buildTimeBox("45", "min"),
                        _buildTimeBox("28", "sec"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      indent: 24.0,
                      endIndent: 24.0,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height:
                          60, // Set a height to ensure the VerticalDivider is visible
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Current Bid:"),
                              const SizedBox(height: 8),
                              const Text.rich(
                                TextSpan(
                                  text: "1.2 M ", // Main text
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.foreOrange,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "LKR", // Smaller, thinner text
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.w400, // Thin font weight
                                        fontSize: 14,
                                        color: AppColors.defaultGray,
// Smaller font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            width: 32, // Spacing between items
                            thickness: 2, // Divider thickness
                            color: Colors.black12, // Divider color
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Recommonded:"),
                              const SizedBox(height: 8),
                              const Text.rich(
                                TextSpan(
                                  text: "1.25 M ", // Main text
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "LKR", // Smaller, thinner text
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.w400, // Thin font weight
                                        fontSize: 14,
// Smaller font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      indent: 24.0,
                      endIndent: 24.0,
                    ),
                    const SizedBox(height: 8),
                    const Text("Your Bid:"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller:
                                TextEditingController(text: "1,200,000"),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center, // Center the text

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    16)), // Custom border radius
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          "LKR",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLoanTypeButton("Custom"),
                        _buildLoanTypeButton("Minimum"),
                        _buildLoanTypeButton("Auto"),
                      ],
                    ),
                  ],
                ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderSummaryScreen()),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildTimeBox(String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 4),
          Text(unit, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildLoanTypeButton(String label) {
    bool isSelected = _selectedLoanType == label;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: isSelected ? 2 : 0,
        backgroundColor: isSelected ? AppColors.darkGreen : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () {
        _onLoanTypeSelected(label);
      },
      child: Text(label),
    );
  }
}
