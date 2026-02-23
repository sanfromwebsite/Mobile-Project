import 'package:flutter/material.dart';

class OurStory extends StatelessWidget {
  const OurStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 40,
              errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.book, color: Color(0xFF33691E)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Story',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B3022), // Dark green title
              ),
            ),
            const SizedBox(height: 24),
            _buildParagraph(
              'Bacon ipsum dolor amet shankle shoulder meatloaf pork tenderloin leberkas porchetta brisket flank pastrami filet mignon kielbasa pork chop jowl. Fatback venison filet mignon, kielbasa chislic tail frankfurter sausage short ribs landjaeger',
            ),
            const SizedBox(height: 16),
            _buildParagraph(
              'Bacon ipsum dolor amet shankle shoulder meatloaf pork tenderloin leberkas porchetta',
            ),
            const SizedBox(height: 16),
            _buildParagraph(
              'Bacon ipsum dolor amet shankle shoulder meatloaf pork tenderloin leberkas porchetta brisket flank pastrami filet mignon kielbasa pork chop jowl. Fatback venison filet mignon, kielbasa chislic tail frankfurter sausage short ribs landjaeger',
            ),
            const SizedBox(height: 40),
            
            // Feature Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFeatureCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Community',
                  description: 'Connect with\nReaders & Authors',
                ),
                _buildFeatureCard(
                  icon: Icons.menu_book_outlined,
                  title: 'Discovery',
                  description: 'New stories & new\nworld',
                ),
                _buildFeatureCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Community',
                  description: 'Connect with\nReaders & Authors',
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black87,
        height: 1.4,
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: const Color(0xFF33691E)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1B3022),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
