import 'package:flutter/material.dart';
import 'package:lovigoapp/screens/userHome.dart';
import 'package:lovigoapp/screens/userProfile.dart';
import 'package:lovigoapp/styles.dart';

class UserMainPage extends StatefulWidget {
  final String accessToken;
  final Map<String, dynamic> userInfo;

  UserMainPage({required this.accessToken, required this.userInfo});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gradientDecoration,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: index,
                children: [
                  Center(child: UserHome()),
                  Center(child: Text('Page 2 Content')),
                  Center(
                    child: UserProfile(
                      accessToken: widget.accessToken,
                      userInfo: widget.userInfo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() {
          this.index = index;
        }),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
            selectedIcon: Icon(Icons.home_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Messages',
            selectedIcon: Icon(Icons.message_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
            selectedIcon: Icon(Icons.person_2_outlined),
          ),
        ],
      ),
    );
  }
}