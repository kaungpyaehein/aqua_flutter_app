import 'package:flutter/material.dart';
import 'package:purifed_water_flutter/admin/more_screen.dart';

import 'order_list_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  
    final List<Widget> _screenList = [
    const OrderListScreen(),
    const MoreScreen(),
  ];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.list), label: "Orders"),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: "More"),
          ]),
      body: _screenList[_currentPageIndex],
    );
  }
}