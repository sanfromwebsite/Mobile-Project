import 'package:flutter/material.dart';
import 'our_story.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header Section
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
            color: const Color(0xFF2D5A27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white70),
                  onPressed: () {},
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {},
                    ),
                    const Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Hero Image Section
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=800&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_write.png',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.book, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Discover your next great\n book',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 3. Main Content Section (With Swipe Detection)
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque, // Ensures the whole area is swipeable
              onVerticalDragEnd: (details) {
                // primaryVelocity < 0 means swiping UP
                // -500 is a standard sensitivity threshold
                if (details.primaryVelocity! < -500) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OurStory(),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF0FFF0), Colors.white],
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to Our Novel!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Our mission is to connect book lovers with a need. '
                      'Making every page turn into an adventure. Explore our '
                      'collections and join our community of readers.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                    ),
                    const Spacer(),
                    // Animated-looking Scroll Arrows
                    Column(
                      children: List.generate(3, (index) => const Icon(
                        Icons.keyboard_double_arrow_up, 
                        color: Color(0xFF2D5A27), 
                        size: 30,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}