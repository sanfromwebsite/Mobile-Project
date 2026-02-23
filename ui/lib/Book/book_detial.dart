import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({super.key});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Header with Curved Background and Book Cover
                _buildScrollableHeader(context),
                
                const SizedBox(height: 24),
                
                // Book Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const Text(
                        'Love Tears',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '\$23.89',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B8E23), // Olive green price
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$23.89',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red[400],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            '|',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          const Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(1.2k Ratings)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B8E23),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Read More',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Watch Book Trailer Card
                      _buildTrailerCard(context),
                      
                      const SizedBox(height: 32),
                      
                      // More From This Author
                      _buildMoreFromAuthor(),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Fixed Top Navigation Bar
          _buildFixedTopBar(context),
        ],
      ),
    );
  }

  Widget _buildFixedTopBar(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Centered Title (Perfectly centered in the screen)
            const Text(
              'Love Tears',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            // 2. Navigation Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),

                // Right Actions (Favorite & Cart)
                Row(
                  children: [
                    _buildNavIcon(
                      icon: Icons.favorite,
                      color: _isFavorite ? Colors.pinkAccent : Colors.white,
                      onTap: () => setState(() => _isFavorite = !_isFavorite),
                    ),
                    const SizedBox(width: 8),
                    _buildNavIcon(
                      icon: Icons.shopping_cart,
                      hasBadge: true,
                      badgeCount: '2',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    Color color = Colors.white,
    bool hasBadge = false,
    String badgeCount = '',
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          if (hasBadge)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  badgeCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScrollableHeader(BuildContext context) {
    return Stack(
      children: [
        // Olive Green Curved Background
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 420,
            width: double.infinity,
            color: const Color(0xFF6B8E23), // Main olive green
          ),
        ),
        
        // Scrollable part of the header (Author and Cover)
        Positioned(
          top: 100, // Offset to leave space for the fixed bar
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Author Name
              const Text(
                'By MiaAnti Gay',
                style: TextStyle(
                  fontFamily: 'Cursive',
                  fontSize: 28,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 3D Book Cover Effect
              _build3DBookCover(),
            ],
          ),
        ),
        
        // Empty space to ensure height for the positioned content
        const SizedBox(height: 420, width: double.infinity),
      ],
    );
  }

  Widget _build3DBookCover() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 1. The main body/thickness (the pages)
          Container(
            height: 265,
            width: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F4), // Premium paper-like color
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(1, 0),
                ),
              ],
            ),
            // The horizontal lines (pages)
            child: Stack(
              children: [
                // Detailed "King" pattern page lines
                Positioned.fill(
                  left: 175, // Only show on the right edge
                  right: 4,
                  top: 5,
                  bottom: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      50, // High density for premium look
                      (index) => Container(
                        height: 0.5,
                        width: double.infinity,
                        color: index % 5 == 0
                            ? Colors.black.withOpacity(0.15) // Every 5th line slightly darker
                            : Colors.black.withOpacity(0.06),
                      ),
                    ),
                  ),
                ),
                // Subtle gradient to simulate shadow from cover
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: const Alignment(0.6, 0.0), // Focus shadow near the spine
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. The Cover Image
          Padding(
            padding: const EdgeInsets.only(left: 6), // Minimal offset for spine look
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              child: Container(
                foregroundDecoration: BoxDecoration(
                  // Spine ridge and lighting effect
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                      Colors.white.withOpacity(0.05),
                    ],
                    stops: const [0.0, 0.04, 0.15, 0.9],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Image.asset(
                  'assets/images/Love Tears.png',
                  height: 275,
                  width: 185,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 275,
                    width: 185,
                    color: Colors.grey[300],
                    child: const Icon(Icons.book, size: 80, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailerCard(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF6B8E23), // Olive green
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Preview thumbnail with play icon overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/Love Tears.png',
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 76,
                      height: 76,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Large Play Button
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Color(0xFF6B8E23), size: 40),
          ),
          
          const SizedBox(width: 20),
          
          // Text Info
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Watch Book Trailer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Official Trailer',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoreFromAuthor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'More From This Author',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/Novel.png',
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    
    // Asymmetric wave curve
    var firstControl = Offset(size.width * 0.4, size.height);
    var firstEnd = Offset(size.width * 0.8, size.height - 100);
    path.quadraticBezierTo(firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    
    var secondControl = Offset(size.width * 0.95, size.height - 150);
    var secondEnd = Offset(size.width, size.height - 250);
    path.quadraticBezierTo(secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
