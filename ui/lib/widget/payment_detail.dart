import 'package:flutter/material.dart';

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF5a7335), // Green background for the top
      appBar: AppBar(
        title: const Text(
          'វិក្កយបត្រ', // Invoice / Receipt
          style: TextStyle(fontFamily: 'Hanuman', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Floating Receipt Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Success Header in Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF5a7335).withOpacity(0.1),
                          ),
                          child: const Icon(Icons.check_rounded, color: Color(0xFF5a7335), size: 50),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'ប្រតិបត្តិការជោគជ័យ', // Transaction Success
                          style: TextStyle(
                            fontFamily: 'Hanuman',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5a7335),
                          ),
                        ),
                        const SizedBox(height: 8),
                         Text(
                          '17-Feb-2026 • 07:25 PM',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider (Dashed)
                  Row(
                    children: List.generate(30, (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    )),
                  ),

                  // Details Section
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          'ចំនួនទឹកប្រាក់សរុប', // Total Amount
                          style: TextStyle(
                            fontFamily: 'Hanuman',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                         Text(
                          '\$ 10.00',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Key Value Pairs
                        _buildDetailRow(context, 'ពីគណនី (From)', 'Sok San'),
                        const SizedBox(height: 16),
                        _buildDetailRow(context, 'ទៅកាន់ (To)', 'COFFEE SHOP KH'),
                        const SizedBox(height: 16),
                        _buildDetailRow(context, 'លេខប្រតិបត្តិការ', 'TXN123456789'),
                        const SizedBox(height: 16),
                        _buildDetailRow(context, 'បរិយាយ (Note)', 'Coffee Payment'),
                      ],
                    ),
                  ),

                  // KHQR Section (Styled nicer)
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[50], // Very light gray in light mode, dark in dark mode
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[100]!),
                          ),
                          child: const Icon(Icons.qr_code_2, size: 40, color: Colors.black87),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "KHQR Payment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 14,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              Text(
                                "ID: 1234 5678 9022",
                                style: TextStyle(color: Colors.grey[500], fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.copy, size: 20, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF5a7335),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'ចែករំលែក', // Share
                        style: TextStyle(
                          fontFamily: 'Hanuman',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF405226), // Darker green for primary action
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'រួចរាល់', // Done
                        style: TextStyle(
                          fontFamily: 'Hanuman',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Hanuman',
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
