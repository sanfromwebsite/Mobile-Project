import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../features/menu/presentation/pages/menu_page.dart';

import 'dart:async';
import 'wishlist_page.dart';
import 'cart_page.dart';

import '../l10n/language_service.dart';

import '../theme/theme_service.dart';
import '../theme/app_theme.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  final TextEditingController _searchController = TextEditingController();

  // Initial Data
  final List<Book> _allBooks = [
    // Popular Books
    Book(
      title: "The Story of Heidi",
      author: "Johanna Spyri",
      color: Colors.lightBlue.shade100,
      isPopular: true,
    ),
    Book(
      title: "Positive Mindset",
      author: "Jason Wolbers",
      color: Colors.orange.shade100,
      isPopular: true,
    ),
    Book(
      title: "Success",
      author: "Mr. Richard",
      color: Colors.yellow.shade100,
      isPopular: true,
    ),
    // New Books
    Book(
      title: "The Power of Hopeful Stories",
      author: "Mr.Richard Kalee",
      price: "\$14.65",
      oldPrice: "\$27.65",
      isNew: true,
    ),
    Book(
      title: "Realistic Fiction Stories",
      author: "Mr.Richard Kalee",
      price: "\$14.65",
      oldPrice: "\$27.65",
      isNew: true,
    ),
    Book(
      title: "Hyper Fiction",
      author: "Mr.Richard Kalee",
      price: "\$14.65",
      oldPrice: "\$27.65",
      isNew: true,
    ),
  ];

  List<Book> _displayedBooks = [];


  @override
  void initState() {
    super.initState();
    _displayedBooks = List.from(_allBooks);
    _startAutoSlide();
  }

  void _filterBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedBooks = List.from(_allBooks);
      } else {
        _displayedBooks = _allBooks.where((book) {
          final titleLower = book.title.toLowerCase();
          final authorLower = book.author.toLowerCase();
          final searchLower = query.toLowerCase();
          return titleLower.contains(searchLower) || authorLower.contains(searchLower);
        }).toList();
      }
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.primary,
      drawer: const SideMenuDrawer(), // Integrating the side menu
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
            IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications_outlined, color: Colors.white),
            ),
            onPressed: () {},
          ),
           IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.favorite_border, color: Colors.white),
            ),
            onPressed: () {
               Navigator.pushNamed(context, '/wishlist');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Header Section (Location & Search)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageService().translate('location'),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      LanguageService().translate('phnom_penh'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _filterBooks,
                                decoration: InputDecoration(
                                  hintText: LanguageService().translate('search'),
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          
          // White Body Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? theme.scaffoldBackgroundColor : const Color(0xFFF5F9F0), // Adaptable BG
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Flash Sale Banner Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#SpecialForYou",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Slider Banner
                      SizedBox(
                        height: 140,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: [
                            _buildBannerItem(
                              "FLASH SALE",
                              "01 : 34 : 46",
                              [const Color(0xFF3E5830), AppColors.primary],
                              Icons.eco,
                            ),
                             _buildBannerItem(
                              "NEW ARRIVALS",
                              "Check out now!",
                              [Colors.orange.shade800, Colors.orange.shade400],
                              Icons.new_releases,
                            ),
                             _buildBannerItem(
                              "BEST SELLERS",
                              "Top 10 Books",
                              [Colors.blue.shade800, Colors.blue.shade400],
                              Icons.star,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Slide Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => _buildIndicator(index == _currentPage)),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Categories
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildCategoryChip("Horror", Icons.psychology_outlined),
                                _buildCategoryChip("Romance Novel", Icons.favorite_border),
                                _buildCategoryChip("Historical", Icons.history_edu),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildCategoryChip("Thriller", Icons.theater_comedy_outlined),
                                _buildCategoryChip("Adventure fiction", Icons.landscape_outlined),
                                _buildCategoryChip("Suspense", Icons.help_outline),
                              ],
                            ),
                             const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildCategoryChip("Graphic Novel", Icons.auto_stories_outlined),
                                _buildCategoryChip("Women's fiction", Icons.face_3_outlined),
                                _buildCategoryChip("Detective", Icons.search),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Popular Section
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _displayedBooks
                              .where((book) => book.isPopular)
                              .map((book) => _buildBookCard(
                                    book.title,
                                    book.author,
                                    book.color ?? Colors.grey.shade100,
                                  ))
                              .toList(),
                        ),
                      ),
                      
                      const SizedBox(height: 25),

                      // New Book Section
                      Text(
                        "New Book",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ..._displayedBooks
                          .where((book) => book.isNew)
                          .map((book) => _buildNewBookItem(
                                book.title,
                                book.author,
                                book.price ?? "",
                                book.oldPrice ?? "",
                              )),
                      
                      const SizedBox(height: 25),

                      // Top Author Section
                      Text(
                        "Top Author",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTopAuthorItem("ថុន ថាវី", ""),
                            _buildTopAuthorItem("ម៉ៅ ចាន់ស្គី", ""),
                            _buildTopAuthorItem("ម៉ៅ សំណាង", ""),
                            _buildTopAuthorItem("អ្នកនិពន្ធថ្មី", ""),
                          ],
                        ),
                      ),
                       const SizedBox(height: 30), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildBannerItem(String title, String subtitle, List<Color> colors, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5), // Spacing between slides
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              icon,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                      Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.book, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCategoryChip(String label, IconData icon) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : const Color(0xFFE8F0E0), // Light green tint in light mode
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF5A7336)), // Darker green icon
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color ?? const Color(0xFF333333),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(String title, String author, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
             child: Center(
               child: Container(
                 width: 50,
                 height: 70,
                 decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.3),
                   borderRadius: BorderRadius.circular(5),
                 ),
                 child: const Center(
                   child: Icon(Icons.bookmark, color: Colors.white, size: 30)
                 ),
               )
             ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF2E7D32), // Dark Green for title
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
           const SizedBox(height: 4),
           Text(
            author,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildNewBookItem(String title, String author, String price, String oldPrice) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
         boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover
          Container(
            width: 80,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
             child: const Center(
               child: Icon(Icons.book, size: 40, color: Colors.grey),
             ),
          ),
          const SizedBox(width: 15),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.favorite_border, color: Color(0xFF2E7D32), size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(width: 8),
                         Text(
                          oldPrice,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2E7D32)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAuthorItem(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade300,
             child: const Icon(Icons.person, size: 35, color: Colors.white),
             // backgroundImage: NetworkImage(imageUrl), // Use this if you have real images
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String? price;
  final String? oldPrice;
  final Color? color;
  final bool isPopular;
  final bool isNew;

  Book({
    required this.title,
    required this.author,
    this.price,
    this.oldPrice,
    this.color,
    this.isPopular = false,
    this.isNew = false,
  });
}
