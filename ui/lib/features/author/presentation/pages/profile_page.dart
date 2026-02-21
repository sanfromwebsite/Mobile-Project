import 'package:flutter/material.dart';


class AuthorProfilePage extends StatelessWidget {
  const AuthorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E6B1E),
      body: SafeArea(
        child: Column(
          children: [

            // Top Green App Barc
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: const Color(0xFF1E6B1E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text(
                    "Miaanti Gay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.share_outlined, color: Colors.white),
                ],
              ),
            ),

            // Body Container
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFE6ECE5),
                  borderRadius: BorderRadius.vertical(
                    //top: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      const SizedBox(height: 25),

                      /// Profile Image
                      CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage("assets/images/test.png"),
                      ),

                      const SizedBox(height: 15),

                      /// Name
                      const Text(
                        "Miaanti Gay",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "New York Times BestSelling Fantasy Author",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),

                      /// Follow Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E6B1E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Follow  +",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// Biography
                      _sectionTitle("Biography"),

                      const SizedBox(height: 10),

                      const Text(
                        "When love turns into obsession, how far will he go "
                        "to keep her by his side? 'Crue! Husband' is a gripping tale "
                        "of passion, betrayal, and redemption. Set in a world where "
                        "secrets unravel with every page, this novel explores "
                        "the fragile line between devotion and control.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            color: Color(0xFF1E6B1E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Books Section
                      _sectionTitle("Books by AntiGay"),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/images/test.png",
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Eyewater",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    "Eyewater",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Featured Works
                      _sectionTitle("Featured Works"),

                      const SizedBox(height: 15),

                      _featuredCard(),
                      const SizedBox(height: 12),
                      _featuredCard(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Featured Card Widget
  Widget _featuredCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/test.png",
              height: 80,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mistborn Title Series",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Fantasy & Series\nby Anti",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
