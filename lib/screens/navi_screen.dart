import 'package:flutter/material.dart';

import 'other_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class NaviPage extends StatefulWidget {
  const NaviPage({super.key});

  @override
  State<NaviPage> createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  List<Widget> screenList = [
    const OtherScreen(),
    const HomeScreen(),
    const ProfileScreen()
  ];
  int _currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.feed), label: "Others"),
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ]),
      body: screenList[_currentPageIndex],
    );
  }
}
