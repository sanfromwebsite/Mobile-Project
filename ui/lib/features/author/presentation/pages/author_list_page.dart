import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AuthorListPage extends StatefulWidget {
  const AuthorListPage({super.key});

  @override
  State<AuthorListPage> createState() => _AuthorListPageState();
}

class _AuthorListPageState extends State<AuthorListPage> {

  int selectedIndex = 0;

  final List<String> categories = [
    "All Author",
    "Popular",
    "Newest",
    "Following",
    "Thriller",
    "Genre",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE5DB),

      body: Column(
        children: [

          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.only(
                top: 20, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Authors",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= CATEGORY TABS =================
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {

                final bool isActive =
                    selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 24),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [

                        /// TEXT
                        Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isActive
                                ? AppColors.primary
                                : Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// DOT (Always reserve space)
                        AnimatedContainer(
                          duration: const Duration(
                              milliseconds: 200),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          /// ================= LIST =================
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              children: const [

                Text(
                  "Featured Trailers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 15),

                AuthorCard(isFollowing: false),
                SizedBox(height: 15),
                AuthorCard(isFollowing: true),
                SizedBox(height: 15),
                AuthorCard(isFollowing: false),
                SizedBox(height: 15),
                AuthorCard(isFollowing: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= AUTHOR CARD =================
class AuthorCard extends StatelessWidget {
  final bool isFollowing;

  const AuthorCard({super.key, required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          const CircleAvatar(
            radius: 28,
            backgroundImage:
                AssetImage("assets/images/test.png"),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Miaanti Gay",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Fantasy & Saga Author",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: isFollowing
                  ? AppColors.primary
                  : const Color(0xFFE6EDE6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Follow",
              style: TextStyle(
                color: isFollowing
                    ? Colors.white
                    : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}