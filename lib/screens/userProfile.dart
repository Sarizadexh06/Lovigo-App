import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'userHome.dart';
import 'package:lovigoapp/styles.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                  Center(child: Text('Page 3 Content')),
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
            label: 'Page 1',
            selectedIcon: Icon(Icons.home_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Page 2',
            selectedIcon: Icon(Icons.message_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Page 3',
            selectedIcon: Icon(Icons.person_2_outlined),
          ),
        ],
      ),
    );
  }
}
