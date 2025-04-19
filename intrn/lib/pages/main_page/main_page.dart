import 'package:flutter/material.dart';
import 'package:intrn/pages/main_page/home_page.dart';
import 'package:intrn/pages/main_page/Listpage.dart';
import 'package:intrn/pages/profile_page/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ListPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: 'List'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 255, 98, 0),
      ),
    );
  }
}
