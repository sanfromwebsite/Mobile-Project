import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final double price;
  final double oldPrice;
  final double rating;
  final String image;
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.image,
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

  final List<Book> _books = [
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
    Book(
      title: 'The mythical capital',
      author: 'Mr.Moon',
      price: 46.76,
      oldPrice: 60.76,
      rating: 4.6,
      image: 'assets/images/Novel.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Integrated Header
          Container(
            color: const Color(0xFF2E7D32),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Menu Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 20),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Second Row: Back Arrow + Title + Actions
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Book Store',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    _buildBadgeIcon(Icons.notifications_outlined, '2'),
                    const SizedBox(width: 8),
                    _buildBadgeIcon(Icons.shopping_cart_outlined, '2'),
                  ],
                ),
                const SizedBox(height: 24),

                // Third Row: Search Bar + Filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune, color: Colors.black87),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Genre List
          Container(
            height: 60,
            color: Colors.white,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _genres.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGenreIndex = index;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        _genres[index],
                        style: TextStyle(
                          color: _selectedGenreIndex == index 
                              ? const Color(0xFF2E7D32) 
                              : Colors.black87,
                          fontWeight: _selectedGenreIndex == index 
                              ? FontWeight.bold 
                              : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      if (_selectedGenreIndex == index)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2E7D32),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Book Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60, // Adjusted for more vertical space
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _books.length,
              itemBuilder: (context, index) {
                return _buildBookCard(_books[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(IconData icon, String badgeText) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookCard(Book book, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        book.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Title
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                
                // Author
                Text(
                  'by ${book.author}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),

                // Price and Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${book.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${book.oldPrice}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red, // Matching screenshot strike color
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Elements overlaid on the image/card
          // Rating Badge
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0B2), // Light orange
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    '${book.rating}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Favorite Heart Icon
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  book.isFavorite = !book.isFavorite;
                });
              },
              child: Icon(
                book.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: book.isFavorite ? Colors.pink : const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
