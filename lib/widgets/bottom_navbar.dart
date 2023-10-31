import 'package:flutter/material.dart';
import 'package:shivsneh/screens/activity/cart_screen.dart';
import 'package:shivsneh/screens/activity/home_screen.dart';
import 'package:shivsneh/screens/activity/profile_screen.dart';
import 'package:shivsneh/widgets/app_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedPageIndex = 0;

  void _selectedPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();

    if (_selectedPageIndex == 1) {
      activeScreen = const CartScreen();
    }
    if (_selectedPageIndex == 2) {
      activeScreen = const OptionsScreen();
    }

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
            child: activeScreen,
          ),
          const SizedBox(
            height: 100,
            child: MyAppBar(titleColor: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_sharp,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
