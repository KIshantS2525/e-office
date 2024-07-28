import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bottom_nav_controller.dart';
import 'notification_page.dart';
import 'profile_page.dart';
import 'service_page.dart';
import 'chatbot_page.dart';
import 'marriage_certificate.dart'; // Import the new page

class UserHomePage extends StatelessWidget {
  final String username;

  UserHomePage({required this.username});

  final BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(username: username),
      ServicesPage(),
      ProfilePage(),
      ChatbotPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        return IndexedStack(
          index: bottomNavController.selectedIndex.value,
          children: pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changeTabIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color.fromARGB(246, 247, 227, 4),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'Track',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chatbot',
            ),
          ],
        );
      }),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  final List<Map<String, String>> services = [
    {'title': 'Birth/Death Certificate', 'image': 'assets/birth_death_certificate.png'},
    {'title': 'Marriage Certificate', 'image': 'assets/marriage_certificate.png'},
    {'title': 'Water Tanker', 'image': 'assets/water_tanker.png'},
    {'title': 'Trading License', 'image': 'assets/trading_license.png'},
    {'title': 'Hoarding License', 'image': 'assets/hoarding_license.png'},
    {'title': 'Garbage Collection Charges', 'image': 'assets/garbage_collection.png'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: -screenWidth * 0.5,
          left: -screenWidth * 0.25,
          child: TopWidget(screenWidth: screenWidth),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile_placeholder.jpg'), // Replace with actual profile image asset
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hello $username,',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // 3D Card with Service Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Services',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle view all action
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (services[index]['title'] == 'Marriage Certificate') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MarriageCertificatePage()),
                                  );
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      services[index]['image']!,
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      services[index]['title']!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopWidget extends StatelessWidget {
  final double screenWidth;

  const TopWidget({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 1.5,
      height: screenWidth * 1.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(1, -0.6),
          end: Alignment(-1, 0.8),
          colors: [
            Color.fromARGB(246, 247, 227, 4),
            Color.fromARGB(197, 144, 252, 94)
          ],
        ),
      ),
    );
  }
}