import 'package:flutter/material.dart';

class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final String description;
  final String? image;

  NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.description,
    this.image,
  });
}

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Icons.book_outlined,
      iconColor: const Color(0xFF2E7D32),
      title: 'អបអរសាទរ ទិវាជ័យជំនះ',
      date: '2024-01-08 7:03 AM',
      description: 'ខួបលើកទី៤៥ នៃទិវាជ័យជំនះលើរបបប្រល័យពូជសាសន៍ ៧ មករា',
      image: 'assets/images/Novel.png',
    ),
    NotificationItem(
      icon: Icons.book_outlined,
      iconColor: const Color(0xFF2E7D32),
      title: 'ថ្ងៃនេះ ជាថ្ងៃសីល ១៥ កើតពេញបូណ៌មី ខែបុស្ស',
      date: '2024-01-08 7:03 AM',
      description: 'សូមអនុមោទនាបុណ្យ កើតមានសេចក្តីសុខគ្រប់ៗគ្នា',
      image: 'assets/images/Novel.png',
    ),
    NotificationItem(
      icon: Icons.book_outlined,
      iconColor: const Color(0xFF2E7D32),
      title: 'ប្រភពសៀវភៅនៅបណ្ណាល័យគិត - From Dream to Reality',
      date: '2024-01-08 7:03 AM',
      description: 'ជាសៀវភៅមួយក្បាល ដែលបានបង្ហាញពីគំនិតអប់រំៗ និងផ្តល់ជូននូវគំនិតនៃការការរស់នៅ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background for the page
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
                const SizedBox(height: 12),
                // Bottom Row: Back button, Title, and Cart
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Notification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 24),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: const Text(
                              '2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Filter Chips Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildFilterChip(
                    'View All',
                    'assets/images/view_all.png',
                    const Color(0xFF4B6A35),
                    true,
                  ),
                  const SizedBox(width: 20),

                  _buildFilterChip(
                    'Sales',
                    'assets/images/Sale.png',
                    const Color(0xFFE69B3D),
                    false,
                  ),
                  const SizedBox(width: 20),

                  _buildFilterChip(
                    'Promotion',
                    'assets/images/Discount.png',
                    const Color(0xFF7E42F5),
                    false,
                  ),
                  const SizedBox(width: 20),

                  _buildFilterChip(
                    'General',
                    'assets/images/General_OCR.png',
                    const Color(0xFFD349F0),
                    false,
                  ),
                ],
              ),
            ),
          ),
          // Notification List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildNotificationCard(context, _notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String imagePath,
    Color color,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFA6A6A6), // Grey pill background
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color, // Colored circular container
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              imagePath,
              width: 28,
              height: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular Avatar with Green Border and Book Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF2E7D32), width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(Icons.auto_stories, color: Color(0xFF2E7D32), size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.date,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              item.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (item.image != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      item.image!,
                      width: MediaQuery.of(context).size.width * 0.7,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
