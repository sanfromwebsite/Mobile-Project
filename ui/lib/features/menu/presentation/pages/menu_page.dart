import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../widget/settings_page.dart';
import '../../../../features/auth/data/auth_service.dart';
import '../../../../features/auth/presentation/pages/login_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Book/book_store.dart';



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

class SideMenuDrawer extends StatefulWidget {
  const SideMenuDrawer({super.key});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  String _name = "Loading...";
  String _email = "Loading...";
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString('user_data');

      if (userDataString != null) {
        final userData = json.decode(userDataString);
        final profile = userData['profile'];
        
        setState(() {
          _email = userData['email'] ?? userData['Email'] ?? "No Email";
          if (profile != null) {
             final fname = profile['fname'] ?? profile['Fname'] ?? "";
             final lname = profile['lname'] ?? profile['Lname'] ?? "";
             _name = "$fname $lname".trim();
             _photoUrl = profile['photo'] ?? profile['Photo'];
          } else {
            _name = "User";
          }
        });
      }
    } catch (e) {
      // Handle error or keep defaults
      setState(() {
        _name = "Error loading user";
      });
    }
  }


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
                    _buildMenuItem(Icons.menu_book_outlined, "សៀវភៅក្នុងហាង", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookStorePage()),
                      );
                    }), // Books in store
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
                   CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    backgroundImage: _photoUrl != null ? NetworkImage(_photoUrl!) : null,
                    child: _photoUrl == null ? const Icon(Icons.person, color: Colors.white) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Call implementing AuthService logout
                      // Note: We need to import AuthService and LoginPage
                       await AuthService().logout();
                       if (context.mounted) {
                         Navigator.pushAndRemoveUntil(
                           context,
                           MaterialPageRoute(builder: (context) => const LoginPage()),
                           (route) => false,
                         );
                       }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.logout, color: Colors.redAccent, size: 16),
                          SizedBox(width: 6),
                          Text(
                            "LogOut",
                            style: TextStyle(
                              color: Colors.redAccent, 
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
