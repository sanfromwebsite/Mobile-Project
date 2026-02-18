import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../widget/settings_page.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Hanuman',
    ),
    home: const MenuPage(),
  ));
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Preview"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Click the icon in the top left to open the menu"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Text("Open Drawer"),
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "OUR - NOVEL",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ហាងលក់សៀវភៅ", // Khmer text approximation from image
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Menu Items List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMenuItem(Icons.home_outlined, "ទំព័រដើម", () {}), // Home
                    _buildMenuItem(Icons.notifications_none_outlined, "ការជូនដំណឹង", () {}), // Notifications
                    _buildMenuItem(Icons.menu_book_outlined, "សៀវភៅក្នុងហាង", () {}), // Books in store
                    _buildMenuItem(Icons.local_offer_outlined, "ប្រូម៉ូសិនពិសេស", () {}), // Special promotion
                    _buildMenuItem(Icons.people_outline, "ប្រភេទអ្នកនិពន្ធសៀវភៅ", () {}), // Author types
                    _buildMenuItem(Icons.videocam_outlined, "វីដេអូសង្ខេបសាច់រឿង", () {}), // Video summary
                    
                    const Divider(color: Colors.white24, height: 30),
                    
                    _buildMenuItem(Icons.phone_outlined, "ទំនាក់ទំនង", () {}), // Contact
                    _buildMenuItem(Icons.info_outline, "អំពីយើង", () {}), // About Us
                    _buildMenuItem(Icons.settings_outlined, "ការកំណត់", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsPage()),
                      );
                    }), // Settings
                  ],
                ),
              ),
            ),

            // Footer - User Profile
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white24)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Linh Sokheng",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "heng@gmail.com",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "LogOut",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            // Bottom Logo
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu_book, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Our Novel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
