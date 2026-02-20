import 'package:flutter/material.dart';
import '../../widget/home_screen.dart';

class Book {
  final String title;
  final String author;
  final double price;
  final double oldPrice;
  final double rating;
  final String image;
  final String category; // Added category field
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.image,
    required this.category, // Required in constructor
    this.isFavorite = false,
  });

  // Factory to create a Book from JSON (API)
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      oldPrice: (json['oldPrice'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      category: json['category'] ?? 'Novel', // Default to Novel if missing
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Method to convert Book to JSON (if needed for POST)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
    };
  }
}

class BookStorePage extends StatefulWidget {
  const BookStorePage({super.key});

  @override
  State<BookStorePage> createState() => _BookStorePageState();
}

class _BookStorePageState extends State<BookStorePage> {
  final List<String> _genres = [
    'All Genre',
    'Novel',
    'Comedy',
    'Fiction',
    'Horror',
    'History',
    'Romance'
  ];
  int _selectedGenreIndex = 0;

  final List<String> _banners = [
    'assets/images/banner1.jpg', // Placeholder
    'assets/images/banner2.jpg', // Placeholder
  ];

  final List<Book> _books = [
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
      category: 'Novel',
      isFavorite: true,
    ),
    Book(
      title: 'The Secret Garden',
      author: 'Frances H. Burnett',
      price: 25.50,
      oldPrice: 32.00,
      rating: 4.8,
      image: 'assets/images/Novel.png', 
      category: 'Fiction',
    ),
    Book(
      title: 'Harry Potter',
      author: 'J.K. Rowling',
      price: 55.00,
      oldPrice: 65.00,
      rating: 4.9,
      image: 'assets/images/Novel.png',
      category: 'Fiction',
    ),
     Book(
      title: 'Khmer History',
      author: 'Ros Chantrabot',
      price: 15.00,
      oldPrice: 18.00,
      rating: 4.5,
      image: 'assets/images/Novel.png',
      category: 'History',
    ),
    Book(
      title: 'It',
      author: 'Stephen King',
      price: 19.99,
      oldPrice: 24.99,
      rating: 4.7,
      image: 'assets/images/Novel.png',
      category: 'Horror',
    ),
    Book(
      title: 'Romance in Paris',
      author: 'Love Expert',
      price: 12.50,
      oldPrice: 15.00,
      rating: 4.2,
      image: 'assets/images/Novel.png',
      category: 'Romance',
    ),
    Book(
      title: 'Hilarious Life',
      author: 'Comedian X',
      price: 10.00,
      oldPrice: 14.00,
      rating: 4.4,
      image: 'assets/images/Novel.png',
      category: 'Comedy',
    ),
  ];

  // Helper to get filtered books
  List<Book> get _filteredBooks {
    if (_selectedGenreIndex == 0) {
      return _books;
    }
    final selectedCategory = _genres[_selectedGenreIndex];
    return _books.where((book) => book.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: Column(
        children: [
          // 1. Stacked Header with Search
          _buildModernHeader(context),
          
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // 2. Promotional Banners
                  _buildBanners(),
                  
                  const SizedBox(height: 25),

                  // 3. Categories / Genres
                  _buildSectionTitle("Categories"),
                  const SizedBox(height: 15),
                  _buildGenreList(),
                  
                  const SizedBox(height: 25),

                  // 4. Filtered Books Grid
                  // Dynamic Title based on selection
                  _buildSectionTitle(_selectedGenreIndex == 0 ? "All Books" : _genres[_selectedGenreIndex]),
                  const SizedBox(height: 15),
                  _buildBookGrid(),

                  const SizedBox(height: 100), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for header area
      child: Stack(
        children: [
          // Green Background with Curves
          Container(
            height: 170, // Slightly less than total height
            decoration: const BoxDecoration(
              color: Color(0xFF5a7335),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                    ),
                    const Text(
                      "Book Store",
                      style: TextStyle(
                        fontFamily: 'Hanuman',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        _buildHeaderIcon(Icons.notifications_none),
                        const SizedBox(width: 10),
                        _buildHeaderIcon(Icons.shopping_cart_outlined),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Floating Search Bar
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search for books, authors...",
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Hanuman'),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF5a7335)),
                  suffixIcon: Icon(Icons.tune, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildBanners() {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        itemCount: 3, // Mock count
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index % 2 == 0 ? const Color(0xFF5a7335).withOpacity(0.8) : Colors.orange.shade300,
              image: const DecorationImage(
                image: AssetImage('assets/images/Novel.png'), // Using existing asset as placeholder
                fit: BoxFit.cover,
                opacity: 0.3
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Best Seller",
                          style: TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5a7335),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "New Arrivals\n50% OFF",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Hanuman',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hanuman',
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildGenreList() {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _genres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _selectedGenreIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedGenreIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF5a7335) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _genres[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hanuman',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookGrid() {
    final displayBooks = _filteredBooks;
    
    // Add logic to handle empty state if needed
    if (displayBooks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(Icons.book_outlined, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 10),
              Text(
                "No books found in this category",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: displayBooks.length,
        itemBuilder: (context, index) => _buildModernBookCard(displayBooks[index]),
      ),
    );
  }

  Widget _buildModernBookCard(Book book) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    image: DecorationImage(
                      image: AssetImage(book.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      book.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: book.isFavorite ? Colors.pink : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Info Area
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Hanuman',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.author,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${book.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF5a7335),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          "${book.rating}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
