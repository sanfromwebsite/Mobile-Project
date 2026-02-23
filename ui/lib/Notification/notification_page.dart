import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String date;
  final String description;
  final String? image;

  NotificationItem({
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
      title: 'អបអរសាទរ ទិវាជ័យជំនះ',
      date: '2024-01-08 7:03 AM',
      description: 'ខួបលើកទី៤៥ នៃទិវាជ័យជំនះលើរបបប្រល័យពូជសាសន៍ ៧ មករា',
      image: 'assets/images/Love Tears.png', // Replace with your image asset
    ),
    NotificationItem(
      title: 'ថ្ងៃនេះ ជាថ្ងៃសីល ១៥ កើតពេញបូណ៌មី ខែបុស្ស',
      date: '2024-01-08 7:03 AM',
      description: 'សូមអនុមោទនាបុណ្យ កើតមានសេចក្តីសុខគ្រប់ៗគ្នា',
      image: 'assets/images/Love Tears.png', // Replace with your image asset
    ),
    NotificationItem(
      title: 'ប្រភពសៀវភៅនៅបណ្ណាល័យគិត - From Dream to Reality',
      date: '2024-01-08 7:03 AM',
      description: 'ជាសៀវភៅមួយក្បាល ដែលបានបង្ហាញពីគំនិតអប់រំៗ និងផ្តល់ជូននូវគំនិតនៃការការរស់នៅ',
      image: 'assets/images/Love Tears.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Dark Green Header
          Container(
            color: const Color(0xFF2E5A27),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 10),
                // Title and Cart
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Notification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Cart Icon with Badge
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Filter Chips (Grey Pills)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterPill('View All', const Color(0xFF4B6A35), 'assets/images/view_all.png'),
                  _buildFilterPill('Sales', const Color(0xFFE69B3D), 'assets/images/Sale.png'),
                  _buildFilterPill('Promotion', const Color(0xFF7E42F5), 'assets/images/Discount.png'),
                  _buildFilterPill('General', const Color(0xFFD349F0), 'assets/images/General_OCR.png'),
                ],
              ),
            ),
          ),

          // 3. Notification List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _buildNotificationCard(context, _notifications[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label, Color circleColor, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.only(left: 4, right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[400], // The grey pill background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: circleColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                imagePath,
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circular Avatar with double green border effect
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2E5A27), width: 1),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4A4A4A)),
                    ),
                    Text(
                      item.date,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.description,
            style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.4),
          ),
          if (item.image != null) ...[
            const SizedBox(height: 12),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.image!,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      width: 200,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}